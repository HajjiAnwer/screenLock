//
//  KeychainStoreQueryable.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/6/20.
//  Copyright © 2020 spare.

import Foundation
import Security
public protocol KeychainStoreQueryable {
    var querry : [String : Any] { get }
}

public class GenericPasswordQueryable : KeychainStoreQueryable {
    let service : String
    
    init(service : String) {
        self.service = service
    }
    
    public var querry: [String : Any] {
        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : service
        ]
        return query
    }
}

public class InternetPasswordQueryable : KeychainStoreQueryable {
    public var querry: [String : Any] = [:]
    
    
}

public class CertificateQueryable : KeychainStoreQueryable {
    public var querry: [String : Any] = [:]
    
    
}

public class IdentifierQueryable : KeychainStoreQueryable {
    public var querry: [String : Any] = [:]
    
    
}

