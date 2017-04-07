//
//  DatabaseResponse.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase

// MARK: - JSONDecodeable

/// <#Description#>
public protocol JSONDecodeable {

    /// <#Description#>
    ///
    /// - Parameter json: <#json description#>
    init?(_ json: JSON)

}

// MARK: - DatabaseResponse

/// <#Description#>
public struct DatabaseResponse {
    
    /// <#Description#>
    public let snapshot: FIRDataSnapshot?
	
    /// <#Description#>
    public let reference: FIRDatabaseReference
	
    /// <#Description#>
    public let isCommitted: Bool
	
}


// MARK: - <#Description#>

public extension DatabaseResponse {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - reference: <#reference description#>
    ///   - snapshot: <#snapshot description#>
    ///   - isCommitted: <#isCommitted description#>
    init(reference: FIRDatabaseReference, snapshot: FIRDataSnapshot? = nil, isCommitted: Bool = false) {
        self.reference = reference
        self.snapshot = snapshot
        self.isCommitted = isCommitted
    }
    
}

// MARK: - Response Decoding

public extension DatabaseResponse {

    /// The FIRDataSnapshot of the response as JSON
    var json: [String: Any]? {
        return snapshot?.value as? JSON
    }
	
    /// Decode the FIRDataSnapshot to a JSONDecodeable type
    ///
    /// - Parameter transform: closure that takes in JSON and returns a JSONDecodeable type
    /// - Returns: decoded object
    /// - Throws: <#throws value description#>
    public func mapTo<T: JSONDecodeable>(_ transform: (JSON) -> T?) throws -> T {
        
        guard let snapshot = snapshot, snapshot.exists() else {
            throw NoraError.nullSnapshot
        }
        
        guard let json = snapshot.value as? JSON else {
            throw NoraError.jsonMapping
        }
        
        guard let result = T(json) else {
            throw NoraError.objectDecoding
        }
        
        return result
        
    }
    
    /// Convert the children of a FIRDataSnapshot to JSON
    ///
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    public func childrenAsJSON() throws -> [JSON] {
        
        guard let snapshot = snapshot, snapshot.exists() else {
            throw NoraError.nullSnapshot
        }
        
        var result: [JSON] = []
        
        for child in snapshot.children {
            guard let snapshot = child as? FIRDataSnapshot, let json = snapshot.value as? JSON else {
                throw NoraError.jsonMapping
            }
            
            result.append(json)
        }
        
        return result
        
    }
    
    /// Decode the children of FIRDataSnapshot to a JSONDecodeable type
    ///
    /// - Parameter transform: a closure taking in JSON and returning a JSONDecodeable type
    /// - Returns: an array of decoded objects
    /// - Throws: <#throws value description#>
    public func mapChildrenTo<T: JSONDecodeable>(_ transform: (JSON) -> T?) throws -> [T] {
        
        let childJSON = try childrenAsJSON()
        
        var result: [T] = []
        
        for json in childJSON {
            guard let decoded = transform(json) else {
                throw NoraError.objectDecoding
            }
            result.append(decoded)
        }
        
        return result
    }
    
}
