//
//  FirebaseTask.swift
//  Nora
//
//  Created by Steven Deutsch on 4/4/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import FirebaseDatabase

/// Represents the read/write methods of Firebase
public enum FirebaseTask {
    
    case observe(FIRDataEventType)
    case observeOnce(FIRDataEventType)
    case setValue
    case updateChildValues
    case removeValue
    case transaction
    
}
