//
//  SecureStoreErrorHandling.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/6/20.
//  Copyright © 2020 spare.

import Foundation

public enum SecureStoreError : Error{
    case stringToDataConversionError
    case dataToStringConversionError
    case dataNotFound
    case unhandledError(message: String)
}

extension SecureStoreError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .stringToDataConversionError:
            return NSLocalizedString("error concertion String to Data", comment: "")
        case .dataToStringConversionError:
            return NSLocalizedString("error concertion Data to String", comment: "")
        case .unhandledError(let message):
            return NSLocalizedString(message, comment: "")
        case .dataNotFound:
            return NSLocalizedString("error Data not found", comment: "")
        }
    }
}
