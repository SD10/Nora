//
//  NRStorageResponse.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseStorage

// MARK: - StorageResponse

public struct NRStorageResponse {
    
    let data: Data?
    let metaData: StorageMetadata?
    let url: URL?
}


public extension NRStorageResponse {
    
    init(data: Data) {
        self.data = data
        self.metaData = nil
        self.url = nil
    }
    
    init(url: URL) {
        self.url = url
        self.metaData = nil
        self.data = nil
    }
    
    init(metaData: StorageMetadata) {
        self.metaData = metaData
        self.url = nil
        self.data = nil
    }
    
}
