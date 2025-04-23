//
//  CryptoResponse.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import Foundation

struct CryptoResponse: Decodable {
    let data: CryptoData
}

struct CryptoData: Decodable {
    let id: String
    let serialId: Int
    let symbol, name, slug: String
    let marketData: MarketData
    let marketcap: Marketcap
    let supply: Supply
}

struct MarketData: Decodable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
}

struct Marketcap: Decodable {
    let currentMarketcapUsd: Double
}

struct Supply: Decodable {
    let circulating: Double
}
