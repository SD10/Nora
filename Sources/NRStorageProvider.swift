//
//  NRStorageProvider.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation
import FirebaseStorage

public typealias StorageCompletion = (Result<NRStorageResponse>) -> Void

public class NRStorageProvider<Target: NRStorageTarget> {
    
    @discardableResult
    public func request(_ target: Target, completion: @escaping StorageCompletion) -> StorageObservableTask? {
        
        let request = NRStorageRequest(target)
        
        switch request.task {
        case .upload, .uploadFile, .update, .downloadMetadata, .delete:
            return processUpload(request, completion)
        case .downloadToURL, .downloadData, .downloadURL:
            return processDownload(request, completion)
        }
    }
    
    private func processUpload(_ request: NRStorageRequest, _ completion: @escaping StorageCompletion) -> StorageUploadTask? {
        
        let writeBlock = { (metaData: StorageMetadata?, error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: metaData, url: nil, error: error)
            completion(response)
        }
        
        let deleteBlock = { (error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: nil, url: nil, error: error)
            completion(response)
        }
        
        var uploadTask: StorageUploadTask?
        
        switch request.task {
        case .upload(let data, let metaData):
            uploadTask = request.reference.putData(data, metadata: metaData, completion: writeBlock)
        case .uploadFile(let url, let metaData):
            uploadTask = request.reference.putFile(from: url, metadata: metaData, completion: writeBlock)
        case .update(let metadata):
            request.reference.updateMetadata(metadata, completion: writeBlock)
        case .downloadMetadata: // this is really a download task
            request.reference.getMetadata(completion: writeBlock)
        case .delete:
            request.reference.delete(completion: deleteBlock)
        default:
            completion(.failure(NRError.requestMapping))
        }
        
        return uploadTask
    }
    
    private func processDownload(_ request: NRStorageRequest, _ completion: @escaping StorageCompletion) -> StorageDownloadTask? {
        
        let dataCompletion = { (data: Data?, error: Error?) in
            let response = self.convertResponseToResult(data: data, metaData: nil, url: nil, error: error)
            completion(response)
        }
        
        let urlCompletion = { (url: URL?, error: Error?) in
            let response = self.convertResponseToResult(data: nil, metaData: nil, url: url, error: error)
            completion(response)
        }
        
        var downloadTask: StorageDownloadTask?
        
        switch request.task {
        case .downloadData(let maxSize):
            downloadTask = request.reference.getData(maxSize: maxSize, completion: dataCompletion)
        case .downloadToURL(let url):
            downloadTask = request.reference.write(toFile: url, completion: urlCompletion)
        case .downloadURL:
            request.reference.downloadURL(completion: urlCompletion)
        default:
            completion(.failure(NRError.requestMapping))
        }
        
        return downloadTask
    }
}

private extension NRStorageProvider {

    func convertResponseToResult(data: Data?, metaData: StorageMetadata?, url: URL?, error: Error?) -> Result<NRStorageResponse> {
        
        switch (data, metaData, url, error) {
        case let (.some(data), _, _, .none):
            let response = NRStorageResponse(data: data)
            return .success(response)
        case let (_, _, .some(url), .none):
            let response = NRStorageResponse(url: url)
            return .success(response)
        case let (_, .some(metaData), _, .none):
            let response = NRStorageResponse(metaData: metaData)
            return .success(response)
        case let (_, _, _, .some(error)):
            return .failure(NRError.underlying(error))
        default:
            return .failure(NRError.resultConversion)
        }
        
    }

}
