//
//  NoraError.swift
//  Nora
//
//  Created by Steven Deutsch on 4/3/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation

// MARK: - FirebaseError

public enum NoraError: Error {
    case nullSnapshot
    case invalidParameters
    case resultConversion
    case requestMapping
    case jsonMapping
    case objectDecoding
    case underlying(Error)
}
