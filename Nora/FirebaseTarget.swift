//
//  FirebaseTarget.swift
//  Nora
//
//  Created by Steven Deutsch on 4/3/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import FirebaseDatabase

public protocol FirebaseTarget {
    
    /// Base reference for your target in Database
    var baseReference: FIRDatabaseReference { get }
    
    /// Path to be appended to the base reference
    var path: String { get }
    
    /// Type of task you want to perform ( Firebase method: eg. observe, observeOnce, setValue, etc. )
    var task: FirebaseTask { get }
    
    /// Values to write for a upload request
    var parameters: [String: Any]? { get }
    
    /// Transaction block to run for .transaction task ( Defaults to FIRTransactionResult.success(withValue: FIRMutableData) )
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult { get }
    
    /// Should task be performed on disconnect ( Defaults to false )
    var onDisconnect: Bool { get }
    
    /// Allow local events for transaction block ( Defaults to false )
    var localEvents: Bool { get }
    
}

public extension FirebaseTarget {
    
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
