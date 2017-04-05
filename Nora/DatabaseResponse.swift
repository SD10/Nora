//
//  DatabaseResponse.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase

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
