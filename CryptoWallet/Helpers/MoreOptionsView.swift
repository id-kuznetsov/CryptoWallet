//
//  MoreOptionsView.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 11.04.2025.
//

import UIKit

final class MoreOptionsView: UIView {
    
    // MARK: - Public Properties
    
    var onUpdateButtonTapped: (() -> Void)?
    var onExitButtonTapped: (() -> Void)?
    
    // MARK: - Private Properties
    
    private lazy var updateButton: CustomMoreMenuButton = {
        CustomMoreMenuButton(
            title: "Обновить",
            image: .icRefresh,
            action: #selector(didTapUpdateButton),
            target: self
        )
    }()
    
    private lazy var exitButton: CustomMoreMenuButton = {
        CustomMoreMenuButton(
            title: "Выйти",
            image: .icTrash,
            action: #selector(didTapExitButton),
            target: self
        )
    }()
    
    // MARK: - Actions
    
    @objc
    private func didTapUpdateButton() {
        onUpdateButtonTapped?()
    }
    
    @objc
    private func didTapExitButton() {
        onExitButtonTapped?()
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [updateButton, exitButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

