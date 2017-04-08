//
//  FirebaseTarget.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

// MARK: - FirebaseTarget

public protocol FirebaseTarget {}

public extension FirebaseTarget {
    
    /// Generate unique id String
    func uniqueID() -> String {
        return UUID().uuidString.lowercased()
    }
    
}

// MARK: - DatabaseTarget

public protocol DatabaseTarget: FirebaseTarget {
    
    /// Base reference for your target in Database
    var baseReference: FIRDatabaseReference { get }
    
    /// Path to be appended to the base reference
    var path: String { get }
    
    /// Type of task you want to perform ( Firebase method: eg. observe, observeOnce, setValue, etc. )
    var task: DatabaseTask { get }
    
    /// Queries to append to the end of the path in order as listed
    var queries: [DatabaseQuery] { get }
    
    /// Transaction block to run for .transaction task ( Defaults to FIRTransactionResult.success(withValue: FIRMutableData) )
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult { get }
    
    /// Should task be performed on disconnect ( Defaults to false )
    var onDisconnect: Bool { get }
    
    /// Allow local events for transaction block ( Defaults to false )
    var localEvents: Bool { get }
    
}

public extension DatabaseTarget {
    
    /// Queries to append to the end of the path in order as listed
    var queries: [DatabaseQuery] {
        return [DatabaseQuery]()
    }
    
    /// Should task be performed on disconnect ( Defaults to false )
    var onDisconnect: Bool {
        return false
    }
    
    /// Allow local events for transaction block ( Defaults to false )
    var localEvents: Bool {
        return false
    }
    
    /// Transaction block to run for .transaction task ( Defaults to FIRTransactionResult.success(withValue: FIRMutableData) )
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult {
        return { (data: FIRMutableData) in
            return FIRTransactionResult.success(withValue: data)
        }
    }
}

// MARK: - StorageTarget

public protocol StorageTarget: FirebaseTarget {
    
    /// Base reference for your target in Storage
    var baseReference: FIRStorageReference { get }
    
    /// Path to be appended to the base reference
    var path: String { get }
    
    /// Type of task you want to perform ( Firebase storage method: eg. put, putFile, write, delete )
    var task: StorageTask { get }
    
}
