//
//  SnakeCaseJSONDecoder.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import Foundation

final class SnakeCaseJSONDecoder: JSONDecoder, @unchecked Sendable {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}

