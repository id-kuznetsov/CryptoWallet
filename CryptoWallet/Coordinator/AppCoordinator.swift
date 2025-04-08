//
//  AppCoordinator.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 08.04.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private let window: UIWindow
    
    // MARK: - Initialisers
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Public Methods
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // TODO: добавить проверку на повторный вход
    }
    
    
}
