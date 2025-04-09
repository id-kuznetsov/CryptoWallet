//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 08.04.2025.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.font = FontStyle.medium.font(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.backgroundColor = .wBackgroundGray1
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }


}

