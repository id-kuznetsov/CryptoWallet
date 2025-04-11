//
//  AuthViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import Foundation

final class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: - Public Properties
    
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    // MARK: - Private Properties
    
    private let authService = AuthService.shared
    private let correctUsername = "1234"
    private let correctPassword = "1234"
    
    // MARK: - Public Methods
    
    func login(username: String, password: String) {
        if username == correctUsername && password == correctPassword {
            authService.setLoggedIn(true)
            onSuccess?()
        } else {
            onFailure?("Введены неправильный логин или пароль")
        }
    }
}
