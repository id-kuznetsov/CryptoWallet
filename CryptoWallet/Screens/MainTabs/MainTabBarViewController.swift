//
//  MainTabBarViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabs()
        setAppearance()
    }
    
    // MARK: - Private Methods
    
    private func setTabs() {
        let cryptoListViewModel = CryptoListViewModel()
        let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)
        let cryptoListNavigationController = UINavigationController(rootViewController: cryptoListViewController)
        cryptoListViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: .icHome,
            tag: 0
        )
        
        let dumbViewController1 = DumbViewController()
        dumbViewController1.tabBarItem = UITabBarItem(
            title: nil,
            image: .icStonks,
            tag: 1
        )
        let dumbViewController2 = DumbViewController()
        dumbViewController2.tabBarItem = UITabBarItem(
            title: nil,
            image: .icWallet,
            tag: 2
        )
        let dumbViewController3 = DumbViewController()
        dumbViewController3.tabBarItem = UITabBarItem(
            title: nil,
            image: .icList,
            tag: 3
        )
        let dumbViewController4 = DumbViewController()
        dumbViewController4.tabBarItem = UITabBarItem(
            title: nil,
            image: .icPerson,
            tag: 4
        )
        
        self.viewControllers = [
            cryptoListNavigationController,
            dumbViewController1,
            dumbViewController2,
            dumbViewController3,
            dumbViewController4
        ]
    }
    
    private func setAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .wBlue
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
