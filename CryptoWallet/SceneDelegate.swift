//
//  SceneDelegate.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 08.04.2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let authService = AuthService.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if authService.isLoggedIn {
            showMainScreen()
        } else {
            showAuthScreen()
        }
        
        window?.makeKeyAndVisible()
    }
    
    private func showAuthScreen() {
        let viewModel = AuthViewModel()
        let authViewController = AuthViewController(viewModel: viewModel)
        window?.rootViewController = authViewController
    }
    
    private func showMainScreen() {
        let mainTabBarViewController = MainTabBarViewController()
        window?.rootViewController = mainTabBarViewController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    
}

