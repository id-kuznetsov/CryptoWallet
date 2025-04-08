//
//  Coordinator.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 08.04.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
