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

// MARK: - NRFirebaseTarget

public protocol NRFirebaseTarget {}

public extension NRFirebaseTarget {
    
    /// Generate unique id String
    func uniqueID() -> String {
        return UUID().uuidString.lowercased()
    }
    
}

// MARK: - NRDatabaseTarget

public protocol NRDatabaseTarget: NRFirebaseTarget {
    
    /// Base reference for your target in Database
    var baseReference: DatabaseReference { get }
    
    /// Path to be appended to the base reference
    var path: String { get }
    
    /// Type of task you want to perform ( Firebase method: eg. observe, observeOnce, setValue, etc. )
    var task: NRDatabaseTask { get }
    
    /// Queries to append to the end of the path in order as listed
    var queries: [NRDatabaseQuery]? { get }
    
    /// Transaction block to run for .transaction task ( Defaults to FIRTransactionResult.success(withValue: FIRMutableData) )
    var transactionBlock: (MutableData) -> TransactionResult { get }
    
    /// Should task be performed on disconnect ( Defaults to false )
    var onDisconnect: Bool { get }
    
    /// Allow local events for transaction block ( Defaults to false )
    var localEvents: Bool { get }
    
}

public extension NRDatabaseTarget {
    
    /// Queries to append to the end of the path in order as listed
    var queries: [NRDatabaseQuery]? {
        return nil
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
    var transactionBlock: (MutableData) -> TransactionResult {
        return { (data: MutableData) in
            return TransactionResult.success(withValue: data)
        }
    }
}

// MARK: - NRStorageTarget

public protocol NRStorageTarget: NRFirebaseTarget {
    
    /// Base reference for your target in Storage
    var baseReference: StorageReference { get }
    
    /// Path to be appended to the base reference
    var path: String { get }
    
    /// Type of task you want to perform ( Firebase storage method: eg. put, putFile, write, delete )
    var task: NRStorageTask { get }
    
}
