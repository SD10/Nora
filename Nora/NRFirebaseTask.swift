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

// MARK: - NRDatabaseTask

/// Represents the read/write methods of Firebase
public enum NRDatabaseTask {
    
    case observe(DataEventType)
    case observeOnce(DataEventType)
    case setValue(Any?)
    case updateChildValues([AnyHashable: Any])
    case removeValue
    case transaction
    
}

// MARK: - NRStorageTask

/// Represents the read/write methods of FirebaseStorage
public enum NRStorageTask {
    
    case upload(Data, StorageMetadata?) // put
    case uploadFile(to: URL, StorageMetadata?) // putFile
    case downloadData(maxSize: Int64) // data
    case downloadToURL(URL) // write
    case downloadURL // downloadURL
    case downloadMetadata // metadata
    case update(StorageMetadata) // update
    case delete // delete
    
}

// MARK: - NRDatabaseQuery

/// Represents the DatabaseQuery methods
public enum NRDatabaseQuery {

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

public extension NRDatabaseQuery {

  func prepare(_ query: DatabaseQuery) -> DatabaseQuery {
    
    switch self {
      case .limitedFirst(let n):
        return query.queryLimited(toFirst: n)
      case .limitedLast(let n):
        return query.queryLimited(toLast: n)
      case .orderedByChild(let key):
        return query.queryOrdered(byChild: key)
      case .orderedByKey:
        return query.queryOrderedByKey()
      case .orderedByValue:
        return query.queryOrderedByValue()
      case .orderedByPriority:
        return query.queryOrderedByPriority()
      case .startingAtValue(let value):
        return query.queryStarting(atValue: value)
      case .startingAt(let value, let childKey):
        return query.queryStarting(atValue: value, childKey: childKey)
      case .endingAtValue(let value):
        return query.queryEnding(atValue: value)
      case .endingAt(let value, let childKey):
        return query.queryEnding(atValue: value, childKey: childKey)
      case .equalToValue(let value):
        return query.queryEqual(toValue: value)
      case .equalTo(let value, let childKey):
        return query.queryEqual(toValue: value, childKey: childKey)
    }
  }

}













