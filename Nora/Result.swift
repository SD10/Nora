//
//  Result.swift
//  ProjectX
//
//  Created by Steven Deutsch on 4/3/17.
//  Copyright © 2017 ProjectX. All rights reserved.
//

import Foundation

// MARK: - Result

public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}

extension Result {

    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error?) {
        self = .failure(error)
    }

}
