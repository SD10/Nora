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

internal struct DatabaseRequest {
    
    var reference: FIRDatabaseReference
    var task: DatabaseTask
    var parameters: [String: Any]?
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult
    var onDisconnect: Bool
    var localEvents: Bool
    
}

internal extension DatabaseRequest {
    
    init(_ target: DatabaseTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
        self.parameters = target.parameters
        self.transactionBlock = target.transactionBlock
        self.onDisconnect = target.onDisconnect
        self.localEvents = target.localEvents
    }
    
}

// MARK: - StorageRequest

internal struct StorageRequest {
    
    let reference: FIRStorageReference
    let task: StorageTask
    
}

internal extension StorageRequest {
    
    init(_ target: StorageTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
    }
    
}
