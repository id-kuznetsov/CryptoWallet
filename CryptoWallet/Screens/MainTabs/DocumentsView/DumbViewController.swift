//
//  DumbViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class DumbViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "TO DO"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
