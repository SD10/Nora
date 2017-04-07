//
//  Request.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

// MARK: - DatabaseRequest

/// <#Description#>
struct DatabaseRequest {
    
    /// <#Description#>
    var reference: FIRDatabaseReference
	
    /// <#Description#>
    var task: DatabaseTask
	
    /// <#Description#>
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult
	
    /// <#Description#>
    var onDisconnect: Bool
	
    /// <#Description#>
    var localEvents: Bool
    
}


// MARK: - <#Description#>

extension DatabaseRequest {
    
    /// <#Description#>
    ///
    /// - Parameter target: <#target description#>
    init(_ target: DatabaseTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
        self.transactionBlock = target.transactionBlock
        self.onDisconnect = target.onDisconnect
        self.localEvents = target.localEvents
    }
    
}

// MARK: - StorageRequest

/// <#Description#>
struct StorageRequest {
    
    /// <#Description#>
    let reference: FIRStorageReference
	
    /// <#Description#>
    let task: StorageTask
    
}


// MARK: - <#Description#>

extension StorageRequest {
    
    /// <#Description#>
    ///
    /// - Parameter target: <#target description#>
    init(_ target: StorageTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
    }
    
}
