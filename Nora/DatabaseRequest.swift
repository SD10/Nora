//
//  DatabaseRequest.swift
//  ProjectX
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 ProjectX. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DatabaseRequest {
    
    var reference: FIRDatabaseReference
    var task: FirebaseTask
    var parameters: [String: Any]?
    var transactionBlock: (FIRMutableData) -> FIRTransactionResult
    var onDisconnect: Bool
    var localEvents: Bool
    
}

extension DatabaseRequest {
    
    init(_ target: FirebaseTarget) {
        self.reference = target.baseReference.child(target.path)
        self.task = target.task
        self.parameters = target.parameters
        self.transactionBlock = target.transactionBlock
        self.onDisconnect = target.onDisconnect
        self.localEvents = target.localEvents
    }
    
}
