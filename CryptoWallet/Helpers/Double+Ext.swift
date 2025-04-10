//
//  Double+Ext.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 11.04.2025.
//

import Foundation

extension Double {
    func formatCurrency(fractionDigits: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = fractionDigits
        numberFormatter.maximumFractionDigits = fractionDigits
        numberFormatter.locale = Locale(identifier: "en_US")
        
        if let formattedAmount = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedAmount
        }
        
        return "0.00"
    }
}
