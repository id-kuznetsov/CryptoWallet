//
//  CryptoListViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import Foundation

protocol CryptoListViewModelProtocol {
    var onLoadingChange: ((Bool) -> Void)? { get set }
    var onCoinsUpdate: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var coinsCount: Int { get }
    
    func getCoin(at index: Int) -> CryptoCurrency?
    func sortItems(by sortOption: SortOption)
    func loadCoins()
}

final class CryptoListViewModel: CryptoListViewModelProtocol {
    
    var onLoadingChange: ((Bool) -> Void)?
    var onCoinsUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private var coinService = CoinMetricsService.shared
    
    private var coins: [CryptoCurrency] = []
    
    var coinsCount: Int {
        coins.count
    }
    
    func getCoin(at index: Int) -> CryptoCurrency? {
        guard index < coins.count else { return nil }
        return coins[index]
    }
    
    func sortItems(by sortOption: SortOption) {
        switch sortOption {
        case .increasing:
            coins.sort { $0.priceUSD < $1.priceUSD }
        case .decreasing:
            coins.sort { $0.priceUSD > $1.priceUSD }
        }
        onCoinsUpdate?()
    }
    
    func loadCoins() {
        onLoadingChange?(true)
        
        let mockCoins = [
            "btc",
            "eth",
            "tron",
            "luna",
            "polkadot",
            "dogecoin",
            "tether",
            "stellar",
            "cardano",
            "xrp"
        ]
        
        var loadedCoins: [CryptoCurrency] = []
        var errors: [Error] = []
        
        let dispatchGroup = DispatchGroup()
        
        for coinName in mockCoins {
            dispatchGroup.enter()
            coinService.fetchCoinMetrics(for: coinName) { result in
                switch result {
                case .success(let coin):
                    let cryptoCurrency = CryptoCurrency(data: coin.data)
                    loadedCoins.append(cryptoCurrency)
                case .failure(let error):
                    errors.append(error)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.onLoadingChange?(false)
            if errors.isEmpty {
                self.coins = loadedCoins
                self.onCoinsUpdate?()
            } else {
                let errorDescription = errors.first?.localizedDescription ?? "Unknown error"
                self.onError?(errorDescription)
            }
        }
    }
}
