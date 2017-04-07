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
///
/// - observe: <#observe description#>
/// - observeOnce: <#observeOnce description#>
/// - setValue: <#setValue description#>
/// - updateChildValues: <#updateChildValues description#>
/// - removeValue: <#removeValue description#>
/// - transaction: <#transaction description#>
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
///
/// - upload: <#upload description#>
/// - uploadFile: <#uploadFile description#>
/// - downloadData: <#downloadData description#>
/// - downloadToURL: <#downloadToURL description#>
/// - downloadURL: <#downloadURL description#>
/// - downloadMetadata: <#downloadMetadata description#>
/// - update: <#update description#>
/// - delete: <#delete description#>
public enum StorageTask {
	
    case upload(Data, FIRStorageMetadata?)
    case uploadFile(to: URL, FIRStorageMetadata?)
    case downloadData(maxSize: Int64)
    case downloadToURL(URL)
    case downloadURL
    case downloadMetadata
    case update(FIRStorageMetadata)
    case delete
	
}
