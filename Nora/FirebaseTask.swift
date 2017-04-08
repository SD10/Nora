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

// MARK: - DatabaseQuery

/// Represents the FIRDatabaseQuery methods
public enum DatabaseQuery {

    case limitedFirst(UInt) // queryLimited(toFirst limit: UInt)
    case limitedLast(UInt) // queryLimited(toLast limit: UInt)
    case orderedByChild(key: String) // queryOrdered(byChild key: String)
    case orderedByKey // queryOrderedByKey()
    case orderedByValue // queryOrderedByValue()
    case orderedByPriority // queryOrderedByPriority
    case startingAtValue(Any?)
    case startingAt(value: Any?, childKey: String?) // queryStarting(atValue: Any?, childKey: String?)
    case endingAtValue(value: Any?) // queryEnding(atValue: Any?)
    case endingAt(value: Any?, childKey: String?) // queryEnding(atValue: Any?, childKey: String?)
    case equalToValue(Any?) // queryEqual(toValue: Any?)
    case equalTo(value: Any, childKey: String?) // queryEqual(toValue value: Any?, childKey: String?)

}













