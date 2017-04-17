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
        self.query = target.queries?.reduce(reference) { $1.prepare($0) } ?? reference
        self.task = target.task
    }
    
}
