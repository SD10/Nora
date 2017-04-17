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

public protocol JSONDecodeable {

    init?(_ json: [String: Any])

}

// MARK: - DatabaseResponse

public struct DatabaseResponse {
    
    public let snapshot: FIRDataSnapshot?
    public let reference: FIRDatabaseReference
    public let isCommitted: Bool
}

public extension DatabaseResponse {
    
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
        return snapshot?.value as? [String: Any]
    }
    
    /// Retrieve value for FIRDataSnapshot for specified key
    /// - Parameter key: key to use to look up value in dictionary
    /// - Returns: value for specified key
    public func mapKey(_ key: String) throws -> Any {
        
        guard let snapshot = snapshot, snapshot.exists() else {
            throw NoraError.nullSnapshot
        }
        
        guard let json = snapshot.value as? [String: Any] else {
            throw NoraError.jsonMapping
        }
        
        guard let result = json[key] else {
            throw NoraError.objectDecoding
        }
        
        return result
    }
    
    /// Decode the FIRDataSnapshot to a JSONDecodeable type
    /// - Parameter transform: closure that takes in JSON and returns a JSONDecodeable type
    /// - Returns: decoded object
    public func mapTo<T: JSONDecodeable>(_ transform: ([String: Any]) -> T?) throws -> T {
        
        guard let snapshot = snapshot, snapshot.exists() else {
            throw NoraError.nullSnapshot
        }
        
        guard let json = snapshot.value as? [String: Any] else {
            throw NoraError.jsonMapping
        }
        
        guard let result = T(json) else {
            throw NoraError.objectDecoding
        }
        
        return result
        
    }
    
    /// Convert the children of a FIRDataSnapshot to JSON
    /// - Returns: an array of the child snapshots as JSON
    public func childrenAsJSON() throws -> [[String: Any]] {
        
        guard let snapshot = snapshot, snapshot.exists() else {
            throw NoraError.nullSnapshot
        }
        
        var result: [[String: Any]] = []
        
        for child in snapshot.children {
            guard let snapshot = child as? FIRDataSnapshot, let json = snapshot.value as? [String: Any] else {
                throw NoraError.jsonMapping
            }
            
            result.append(json)
        }
        
        return result
        
    }
    
    /// Decode the children of FIRDataSnapshot to a JSONDecodeable type
    /// - Parameter transform: a closure taking in JSON and returning a JSONDecodeable type
    /// - Returns: an array of decoded objects
    public func mapChildrenTo<T: JSONDecodeable>(_ transform: ([String: Any]) -> T?) throws -> [T] {
        
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
