//
//  FirebaseTask.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

// MARK: - DatabaseTask

/// Represents the read/write methods of Firebase
public enum DatabaseTask {
    
    case observe(FIRDataEventType)
    case observeOnce(FIRDataEventType)
    case setValue(Any?)
    case updateChildValues([AnyHashable: Any])
    case removeValue
    case transaction
    
}

// MARK: - StorageTask

/// Represents the read/write methods of FirebaseStorage
public enum StorageTask {
    
    case upload(Data, FIRStorageMetadata?) // put
    case uploadFile(to: URL, FIRStorageMetadata?) // putFile
    case downloadData(maxSize: Int64) // data
    case downloadToURL(URL) // write
    case downloadURL // downloadURL
    case downloadMetadata // metadata
    case update(FIRStorageMetadata) // update
    case delete // delete
    
}
