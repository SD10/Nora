//
//  NRError.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation

// MARK: - NRError

public enum NRError: Error {
    
    case resultConversion
    
    case requestMapping
    
    case nullSnapshot
    
    case jsonMapping
    
    case objectDecoding
    
    case underlying(Error)
    
}

// MARK: - LocalizedError

extension NRError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .resultConversion:
            return "There was an error converting the Response to a Result."
        case .requestMapping:
            return "There was an error mapping the Request to Firebase."
        case .nullSnapshot:
            return "The FIRDataSnapshot is empty."
        case .jsonMapping:
            return "The FIRDataSnapshot to JSON conversion failed."
        case .objectDecoding:
            return "The object decoding for the Response failed."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
