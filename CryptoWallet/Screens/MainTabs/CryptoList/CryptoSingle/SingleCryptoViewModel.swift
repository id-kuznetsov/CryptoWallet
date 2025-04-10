//
//  SingleCryptoViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import Foundation

protocol SingleCryptoViewModelProtocol {
    var coin: CryptoCurrency { get }
}

final class SingleCryptoViewModel: SingleCryptoViewModelProtocol {
    
    var coin: CryptoCurrency
    
    init(coin: CryptoCurrency) {
        self.coin = coin
    }
}
