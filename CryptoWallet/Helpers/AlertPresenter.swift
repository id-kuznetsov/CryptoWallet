//
//  AlertPresenter.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class AlertPresenter {

    static func presentAlertWithTwoSelections(on viewController: UIViewController,
                                              title: String,
                                              message: String? = nil,
                                              firstActionTitle: String,
                                              firstActionCompletion: (() -> Void)? = nil,
                                              secondActionTitle: String,
                                              secondActionCompletion: (() -> Void)? = nil,
                                              preferredStyle: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let firstAction = UIAlertAction(title: firstActionTitle, style: .default) { _ in
            firstActionCompletion?()
        }
        let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { _ in
            secondActionCompletion?()
        }
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)

        viewController.present(alertController, animated: true)
    }

}
