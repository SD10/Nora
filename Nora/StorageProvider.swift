//
//  StorageProvider.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseStorage

/// <#Description#>
public typealias StorageCompletion = (Result<StorageResponse>) -> Void

/// <#Description#>
public class StorageProvider<Target: StorageTarget> {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - completion: <#completion description#>
    /// - Returns: <#return value description#>
    @discardableResult
    public func request(_ target: Target, completion: @escaping StorageCompletion) -> FIRStorageObservableTask? {
        
        let request = StorageRequest(target)
        
        switch request.task {
        case .upload, .uploadFile, .update, .downloadMetadata, .delete:
            return processUpload(request, completion)
        case .downloadToURL, .downloadData, .downloadURL:
            return processDownload(request, completion)
        }
    }
    
    private func processUpload(_ request: StorageRequest, _ completion: @escaping StorageCompletion) -> FIRStorageUploadTask? {
        
        let writeBlock = { (metaData: FIRStorageMetadata?, error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: metaData, url: nil, error: error)
            completion(response)
        }
        
        let deleteBlock = { (error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: nil, url: nil, error: error)
            completion(response)
        }
        
        var uploadTask: FIRStorageUploadTask?
        
        switch request.task {
        case .upload(let data, let metaData):
            uploadTask = request.reference.put(data, metadata: metaData, completion: writeBlock)
        case .uploadFile(let url, let metaData):
            uploadTask = request.reference.putFile(url, metadata: metaData, completion: writeBlock)
        case .update(let metadata):
            request.reference.update(metadata, completion: writeBlock)
        case .downloadMetadata: // this is really a download task
            request.reference.metadata(completion: writeBlock)
        case .delete:
            request.reference.delete(completion: deleteBlock)
        default:
            completion(.failure(NoraError.requestMapping))
        }
        
        return uploadTask
    }
    
    private func processDownload(_ request: StorageRequest, _ completion: @escaping StorageCompletion) -> FIRStorageDownloadTask? {
        
        let dataCompletion = { (data: Data?, error: Error?) in
            let response = self.convertResponseToResult(data: data, metaData: nil, url: nil, error: error)
            completion(response)
        }
        
        let urlCompletion = { (url: URL?, error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: nil, url: url, error: error)
            completion(response)
        }
        
        var downloadTask: FIRStorageDownloadTask?
        
        switch request.task {
        case .downloadData(let maxSize):
            downloadTask = request.reference.data(withMaxSize: maxSize, completion: dataCompletion)
        case .downloadToURL(let url):
            downloadTask = request.reference.write(toFile: url, completion: urlCompletion)
        case .downloadURL:
            request.reference.downloadURL(completion: urlCompletion)
        default:
            completion(.failure(NoraError.requestMapping))
        }
        
        return downloadTask
    }
}

// MARK: - <#Description#>

private extension StorageProvider {

    func convertResponseToResult(data: Data?, metaData: FIRStorageMetadata?, url: URL?, error: Error?) -> Result<StorageResponse> {
        
        switch (data, metaData, url, error) {
        case let (.some(data), _, _, .none):
            let response = StorageResponse(data: data)
            return .success(response)
        case let (_, _, .some(url), .none):
            let response = StorageResponse(url: url)
            return .success(response)
        case let (_, .some(metaData), _, .none):
            let response = StorageResponse(metaData: metaData)
            return .success(response)
        case let (_, _, _, .some(error)):
            return .failure(NoraError.underlying(error))
        default:
            return .failure(NoraError.resultConversion)
        }
        
    }

}
