//
//  NoraError.swift
//  Nora
//
//  Created by Steven on 4/4/17.
//  Copyright © 2017 NoraFirebase. All rights reserved.
//

import Foundation

// MARK: - NoraError

public enum NoraError: Error {
    case resultConversion
    case requestMapping
    case underlying(Error)
}
