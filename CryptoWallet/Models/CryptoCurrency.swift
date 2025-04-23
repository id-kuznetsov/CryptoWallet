//
//  CryptoCurrency .swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

struct CryptoCurrency {
    let id: String
    let name: String
    let symbol: String
    let priceUSD: Double
    let percentChange24h: Double
    let marketCapUSD: Double
    let circulatingSupply: Double
    let image: UIImage?

    init(
        id: String,
        name: String,
        symbol: String,
        priceUSD: Double,
        percentChange24h: Double,
        marketCapUSD: Double,
        circulatingSupply: Double,
        image: UIImage?
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.priceUSD = priceUSD
        self.percentChange24h = percentChange24h
        self.marketCapUSD = marketCapUSD
        self.circulatingSupply = circulatingSupply
        self.image = image
    }
    
    init(data: CryptoData) {
        self.id = data.id
        self.name = data.name
        self.symbol = data.symbol
        self.priceUSD = data.marketData.priceUsd
        self.percentChange24h = data.marketData.percentChangeUsdLast24Hours
        self.marketCapUSD = data.marketcap.currentMarketcapUsd
        self.circulatingSupply = data.supply.circulating
        self.image = nil // TODO: в api нет картинки
    }
}
