//
//  CustomMoreMenuButton.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 11.04.2025.
//

import UIKit

final class CustomMoreMenuButton: UIButton {

    init(title: String, image: UIImage?, action: Selector, target: Any?) {
        super.init(frame: .zero)
        setupButton(title: title, image: image, action: action, target: target)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupButton(title: String, image: UIImage?, action: Selector, target: Any?) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = image
        configuration.baseForegroundColor = .wTextTitle
        titleLabel?.font = FontStyle.medium.font(size: 18)
        configuration.imagePadding = 8
        configuration.titleAlignment = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        self.configuration = configuration
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.contentHorizontalAlignment = .leading
        if let target = target {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

