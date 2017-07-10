//
//  StorageRequest.swift
//  Nora
//
//  Created by Steven on 4/8/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseStorage

// MARK: - StorageRequest

struct StorageRequest {
    
    let reference: StorageReference
    let task: NRStorageTask
    
}

extension StorageRequest {
    
    init(_ target: StorageTarget) {
        self.reference = target.path == "" ? target.baseReference : target.baseReference.child(target.path)
        self.task = target.task
    }
    
}
