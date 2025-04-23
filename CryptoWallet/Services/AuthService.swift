//
//  AuthService.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import Foundation

final class AuthService {
    
    static let shared = AuthService()
    
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
    }
    
    private init() {}
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: Keys.isLoggedIn)
    }
    
    func setLoggedIn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Keys.isLoggedIn)
    }
}

