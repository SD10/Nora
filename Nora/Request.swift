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

// MARK: - StorageRequest

struct StorageRequest {
    
    let reference: FIRStorageReference
    let task: StorageTask
    
}

extension StorageRequest {
    
    init(_ target: StorageTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
    }
    
}
