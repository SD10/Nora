//
//  Result.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation

// MARK: - Result

/// <#Description#>
///
/// - success: <#success description#>
/// - failure: <#failure description#>
public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

// MARK: - <#Description#>

public extension Result {
    
    /// <#Description#>
    ///
    /// - Parameter value: <#value description#>
    init(value: Value) {
        self = .success(value)
    }
    
    /// <#Description#>
    ///
    /// - Parameter error: <#error description#>
    init(error: Error) {
        self = .failure(error)
    }
    
}
