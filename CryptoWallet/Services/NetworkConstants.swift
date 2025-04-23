//
//  NetworkConstants.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 12.04.2025.
//

import Foundation

enum NetworkConstants {
    static let baseURL = "https://data.messari.io/api/v1/assets/"
    static let metricsPath = "/metrics"
}

struct HTTPMethod {
    static let get = "GET"
}
