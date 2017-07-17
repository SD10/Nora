//
//  NRDatabaseRequest.swift
//  Nora
//
//  Created by Steven on 4/8/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase

// MARK: - NRDatabaseRequest

struct NRDatabaseRequest {
    
    var reference: DatabaseReference
    var task: NRDatabaseTask
    var transactionBlock: (MutableData) -> TransactionResult
    var onDisconnect: Bool
    var localEvents: Bool
    
}

extension NRDatabaseRequest {
    
    init(_ target: NRDatabaseTarget) {
        self.reference = target.path == "" ? target.baseReference : target.baseReference.child(target.path)
        self.task = target.task
        self.transactionBlock = target.transactionBlock
        self.onDisconnect = target.onDisconnect
        self.localEvents = target.localEvents
    }
}

// MARK: - DatabaseQueryRequest

struct NRDatabaseQueryRequest {
    
    var query: DatabaseQuery
    var task: NRDatabaseTask
    
}

extension NRDatabaseQueryRequest {
    
    init(_ target: NRDatabaseTarget) {
        let reference = target.path == "" ? target.baseReference : target.baseReference.child(target.path)
        self.query = target.queries?.reduce(reference) { $1.prepare($0) } ?? reference
        self.task = target.task
    }
    
}
