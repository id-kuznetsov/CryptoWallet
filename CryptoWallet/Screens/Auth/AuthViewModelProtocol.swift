//
//  AuthViewModelProtocol.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 11.04.2025.
//

import Foundation

protocol AuthViewModelProtocol {
    var onSuccess: (() -> Void)? { get set }
    var onFailure: ((String) -> Void)? { get set }
    func login(username: String, password: String)
}
