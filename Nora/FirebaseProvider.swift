//
//  FirebaseProvider.swift
//  Nora
//
//  Created by Steven Deutsch on 4/3/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import FirebaseDatabase

public typealias FirebaseCompletion = (Result<Response>) -> Void
public typealias TransactionBlock = (FIRMutableData) -> FIRTransactionResult
public typealias JSON = [String: Any]

public class FirebaseProvider<Target: FirebaseTarget> {
    
    @discardableResult
    public func request(_ target: Target, completion: @escaping FirebaseCompletion) -> UInt? {
        
        var handle: UInt?
        let request = DatabaseRequest(target)
        
        switch request.task {
        case .observe, .observeOnce:
            handle = processObserve(request, completion)
        case .setValue, .updateChildValues, .removeValue:
            processWrite(request, completion)
        case .transaction:
            processTransaction(request, completion)
        }
        return handle
    }
    
    func processObserve(_ request: DatabaseRequest, _ completion: @escaping FirebaseCompletion) -> UInt? {
        
        let successMapping = { (snapshot: FIRDataSnapshot) in
            let result = self.convertResponseToResult(snapshot: snapshot, reference: request.reference, error: nil)
            completion(result)
        }
        
        let failureMapping = { (error: Error?) in
            let result = self.convertResponseToResult(snapshot: nil, reference: nil, error: error)
            completion(result)
        }
        
        var handle: UInt?
        
        switch request.task {
        case .observe(let event):
            handle = request.reference.observe(event, with: successMapping, withCancel: failureMapping)
        case .observeOnce(let event):
            request.reference.observeSingleEvent(of: event, with: successMapping, withCancel: failureMapping)
        default:
            completion(.failure(FirebaseError.requestMapping))
        }
        
        return handle
    }
    
    func processWrite(_ request: DatabaseRequest, _ completion: @escaping FirebaseCompletion) {
        
        let completionBlock = { (error: Error?, reference: FIRDatabaseReference) in
            let result = self.convertResponseToResult(snapshot: nil, reference: reference, error: error)
            completion(result)
        }
        
        switch request.task {
        case .setValue:
            
            if request.onDisconnect {
                request.reference.onDisconnectSetValue(request.parameters, withCompletionBlock: completionBlock)
            } else {
                request.reference.setValue(request.parameters, withCompletionBlock: completionBlock)
            }
            
        case .updateChildValues:
            
            guard let values = request.parameters else {
                completion(.failure(FirebaseError.invalidParameters))
                break
            }
            
            if request.onDisconnect {
                request.reference.onDisconnectUpdateChildValues(values, withCompletionBlock: completionBlock)
            } else {
                request.reference.updateChildValues(values, withCompletionBlock: completionBlock)
            }
            
        case .removeValue:
            
            if request.onDisconnect {
                request.reference.onDisconnectRemoveValue(completionBlock: completionBlock)
            } else {
                request.reference.removeValue(completionBlock: completionBlock)
            }
            
        default:
            completion(.failure(FirebaseError.requestMapping))
        }
    }
    
    func processTransaction(_ request: DatabaseRequest, _ completion: @escaping FirebaseCompletion) {
        
        let transactionCompletion = { (error: Error?, committed: Bool, snapshot: FIRDataSnapshot?) in
            let result = self.convertResponseToResult(snapshot: snapshot, reference: request.reference, error: error, committed: committed)
            completion(result)
        }
        
        request.reference.runTransactionBlock(request.transactionBlock, andCompletionBlock: transactionCompletion, withLocalEvents: request.localEvents)
    }
}

private extension FirebaseProvider {
    
    
    func convertResponseToResult(snapshot: FIRDataSnapshot?, reference: FIRDatabaseReference?, error: Error?, committed: Bool? = nil) -> Result<Response> {
        
        switch (snapshot, reference, error, committed) {
        case let (snapshot, .some(reference), .none, .some(committed)):
            let response = Response(reference: reference, snapshot: snapshot, isCommitted: committed)
            return .success(response)
        case let (.some(snapshot), .some(reference), .none, _):
            let response = Response(reference: reference, snapshot: snapshot, isCommitted: true)
            return snapshot.exists() ? .success(response) : .failure(FirebaseError.nullSnapshot)
        case let (.none, .some(reference), .none, _):
            let response = Response(reference: reference, isCommitted: true)
            return .success(response)
        case let (.none, _, .some(error), _):
            return .failure(FirebaseError.underlying(error))
        default:
            return .failure(FirebaseError.resultConversion)
        }
    }
    
}


