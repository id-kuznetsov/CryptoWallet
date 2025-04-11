//
//  SortOption.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import Foundation

enum SortOption: CaseIterable {
    case increasing
    case decreasing

    var title: String {
        switch self {
        case .increasing:
            "по возрастанию"
        case .decreasing:
            "по убыванию"
        }
    }
}
