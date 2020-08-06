//
//  KeychainService.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import Foundation
import Security

class KeychainService : NSObject{
    
    let keychainClass : KeychainStoreQueryable
    var querry : [String : Any] = [:]
    
    init(keychainClass : KeychainStoreQueryable) {
        self.keychainClass = keychainClass
        self.querry = keychainClass.querry
    }
    
    func update (newData : [String : Any], query : [String : Any]) throws {
        let updateStatus = SecItemUpdate(query as CFDictionary, newData as CFDictionary)
        if updateStatus != errSecSuccess {
            if #available(iOS 11.3, *) {
                throw SecureStoreError.unhandledError(message: SecCopyErrorMessageString(updateStatus, nil) as String? ?? NSLocalizedString(NavigatorManager.shared.unhadledErrorMessage, comment: ""))
            }
        }
    }
    
    func save (query : [String : Any]) throws {
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        if addStatus != errSecSuccess {
            if #available(iOS 11.3, *) {
                throw SecureStoreError.unhandledError(message: SecCopyErrorMessageString(addStatus, nil) as String? ?? NSLocalizedString(NavigatorManager.shared.unhadledErrorMessage, comment: ""))
            }
        }
    }
    
    func delete(key: String) throws{
        querry [kSecAttrAccount as String] = key
        let status =  SecItemDelete(querry as CFDictionary)
        if status == errSecSuccess || status == errSecItemNotFound {
            if #available(iOS 11.3, *) {
                throw SecureStoreError.unhandledError(message: SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString(NavigatorManager.shared.unhadledErrorMessage, comment: ""))
            }
        }
    }
    
    func addOrUpdate(key : String , data : String) throws {
        guard let data = data.data(using: .utf8) else {throw SecureStoreError.stringToDataConversionError}
        querry[kSecAttrAccount as String] = key
        let status : OSStatus = SecItemCopyMatching(querry as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var newData : [String : Any] = [:]
            newData[kSecValueData as String] = data
            try update(newData: newData, query: querry)
        case errSecItemNotFound :
            querry[kSecValueData as String] = data
            try save(query: querry)
        default :
            if #available(iOS 11.3, *) {
                throw SecureStoreError.unhandledError(message: SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString(NavigatorManager.shared.unhadledErrorMessage, comment: ""))
            }
        }
    }
    
    func load(key: String) throws -> Data? {
        querry[kSecAttrAccount as String] = key
        querry[kSecReturnData as String] = kCFBooleanTrue!
        querry[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(querry as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as! Data?
        } else {
            if #available(iOS 11.3, *) {
                throw SecureStoreError.unhandledError(message: SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString(NavigatorManager.shared.unhadledErrorMessage, comment: ""))
            }
            return nil
        }
    }

}

