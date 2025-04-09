//
//  AuthViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

class AuthViewController: UIViewController {

    // MARK: - Public Properties
    
    
    
    // MARK: - Private Properties
    
    private lazy var authImageView: UIImageView = {
        let imageView = UIImageView(image: .auth)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = FontStyle.semiBold.font(size: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 27.5
        button.layer.masksToBounds = true
        button.backgroundColor = .wBlue
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var usernameTextField: CustomTextField = {
        let textField = CustomTextField(backgroundText: "Username", image: .icUser)
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(backgroundText: "Password", image: .icPassword)
        return textField
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - Initialisers
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Action
    
    @objc
    private func loginButtonTapped() {
        // TODO: login logic
    }
    
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .wBackgroundGray1
        
        let subviews = [authImageView, textFieldsStackView, loginButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            authImageViewConstraints() +
            textFieldsStackViewConstraints() +
            loginButtonConstraints()
        )
    }
    
    private func authImageViewConstraints() -> [NSLayoutConstraint] {
        [
            authImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 44),
            authImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -44),
            authImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            authImageView.heightAnchor.constraint(equalToConstant: 287)
        ]
    }
    
    private func textFieldsStackViewConstraints() -> [NSLayoutConstraint] {
        [
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            textFieldsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            textFieldsStackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -25)
        ]
    }
    
    private func loginButtonConstraints() -> [NSLayoutConstraint] {
        [
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133)
        ]
    }
    


}

// MARK: - extensions
