//
//  CryptoCurrency .swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import Foundation

struct CryptoCurrency {
    let id: String
    let name: String
    let symbol: String
    let priceUSD: Double
    let percentChange24h: Double
    let marketCapUSD: Double
    let circulatingSupply: Double
    let imageUrl: String?
}
