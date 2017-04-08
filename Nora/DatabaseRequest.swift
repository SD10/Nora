//
//  DatabaseRequest.swift
//  Nora
//
//  Created by Steven on 4/8/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase

// MARK: - DatabaseRequest

struct DatabaseRequest {
    
    var reference: FIRDatabaseReference
    var task: DatabaseTask
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult
    var onDisconnect: Bool
    var localEvents: Bool
    
}

extension DatabaseRequest {
    
    init(_ target: DatabaseTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
        self.transactionBlock = target.transactionBlock
        self.onDisconnect = target.onDisconnect
        self.localEvents = target.localEvents
    }
}

// MARK: - DatabaseQueryRequest

struct DatabaseQueryRequest {
    
    var query: FIRDatabaseQuery
    var task: DatabaseTask
    
}

extension DatabaseQueryRequest {
    
    init(_ target: DatabaseTarget) {
        let reference = target.baseReference.child(target.path)
        self.query = DatabaseQueryRequest.applyQueries(target.queries, toReference: reference)
        self.task = target.task
    }
    
}

private extension DatabaseQueryRequest {
    
    static func applyQueries(_ queries: [DatabaseQuery], toReference reference: FIRDatabaseReference) -> FIRDatabaseQuery {
        
        var dbQuery = reference as FIRDatabaseQuery
        
        guard !queries.isEmpty else { return dbQuery }
        
        for query in queries {
            
            switch query {
            case .limitedFirst(let n):
                dbQuery = dbQuery.queryLimited(toFirst: n)
            case .limitedLast(let n):
                dbQuery = dbQuery.queryLimited(toLast: n)
            case .orderedByChild(let key):
                dbQuery = dbQuery.queryOrdered(byChild: key)
            case .orderedByKey:
                dbQuery = dbQuery.queryOrderedByKey()
            case .orderedByValue:
                dbQuery = dbQuery.queryOrderedByValue()
            case .orderedByPriority:
                dbQuery = dbQuery.queryOrderedByPriority()
            case .startingAtValue(let value):
                dbQuery = dbQuery.queryStarting(atValue: value)
            case .startingAt(let value, let childKey):
                dbQuery = dbQuery.queryStarting(atValue: value, childKey: childKey)
            case .endingAtValue(let value):
                dbQuery = dbQuery.queryEnding(atValue: value)
            case .endingAt(let value, let childKey):
                dbQuery = dbQuery.queryEnding(atValue: value, childKey: childKey)
            case .equalToValue(let value):
                dbQuery = dbQuery.queryEqual(toValue: value)
            case .equalTo(let value, let childKey):
                dbQuery = dbQuery.queryEqual(toValue: value, childKey: childKey)
            }
        }
        
        return dbQuery
    }
}
