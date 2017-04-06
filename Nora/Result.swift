//
//  Result.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation

// MARK: - Result

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public extension Result {
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
    
}
