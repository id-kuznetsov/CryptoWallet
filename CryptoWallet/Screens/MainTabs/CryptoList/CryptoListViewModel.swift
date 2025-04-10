//
//  CryptoListViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import Foundation

protocol CryptoListViewModelProtocol {
    var coinsCount: Int { get }
    
    func getCoin(at index: Int) -> CryptoCurrency?
}

final class CryptoListViewModel: CryptoListViewModelProtocol {
    
    private var coins: [CryptoCurrency] = [
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        ),
        CryptoCurrency(
            id: "1",
            name: "Bitcoin",
            symbol: "BTC",
            priceUSD: 32128.80,
            percentChange24h: 2.5,
            marketCapUSD: 231233,
            circulatingSupply: 114.211 ,
            imageUrl: .bitcoin
        )
    ]
    
    var coinsCount: Int {
        coins.count
    }
    
    func getCoin(at index: Int) -> CryptoCurrency? {
        guard index < coins.count else { return nil }
        return coins[index]
    }
}
