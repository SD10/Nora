//
//  Response.swift
//  ProjectX
//
//  Created by Steven Deutsch on 4/3/17.
//  Copyright © 2017 ProjectX. All rights reserved.
//

import Foundation
import FirebaseDatabase

// MARK: - Response

public struct Response {
    
    public let snapshot: FIRDataSnapshot?
    public let reference: FIRDatabaseReference
    public let isCommitted: Bool
}

extension Response {
    
    init(reference: FIRDatabaseReference, snapshot: FIRDataSnapshot? = nil, isCommitted: Bool = false) {
        self.reference = reference
        self.snapshot = snapshot
        self.isCommitted = isCommitted
    }
    
}

