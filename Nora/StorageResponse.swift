//
//  StorageResponse.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseStorage

// MARK: - StorageResponse

/// <#Description#>
public struct StorageResponse {
    
    /// <#Description#>
    let data: Data?
	
    /// <#Description#>
    let metaData: FIRStorageMetadata?
	
    /// <#Description#>
    let url: URL?
	
}


// MARK: - <#Description#>

public extension StorageResponse {
    
    /// <#Description#>
    ///
    /// - Parameter data: <#data description#>
    init(data: Data) {
        self.data = data
        self.metaData = nil
        self.url = nil
    }
    
    /// <#Description#>
    ///
    /// - Parameter url: <#url description#>
    init(url: URL) {
        self.url = url
        self.metaData = nil
        self.data = nil
    }
    
    /// <#Description#>
    ///
    /// - Parameter metaData: <#metaData description#>
    init(metaData: FIRStorageMetadata) {
        self.metaData = metaData
        self.url = nil
        self.data = nil
    }
    
}
