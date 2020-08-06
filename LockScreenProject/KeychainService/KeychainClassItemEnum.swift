//
//  KeychainClassItemEnum.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/6/20.
//  Copyright © 2020 spare.

import Foundation

public enum KeychainCalssItemEnum {
    case GenericPassword
    case InternetPassword
    case Certificate
    case Idenitifer
    
    public var keychainItem : KeychainStoreQueryable {
        switch self {
        case .GenericPassword:
            return GenericPasswordQueryable(service: NavigatorManager.shared.service)
        case .InternetPassword:
            return InternetPasswordQueryable()
        case .Certificate:
            return CertificateQueryable()
        case .Idenitifer:
            return IdentifierQueryable()
        }
    }
}
