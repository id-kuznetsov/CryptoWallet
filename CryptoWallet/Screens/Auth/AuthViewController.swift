//
//  AuthViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: AuthViewModelProtocol
    
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
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(backgroundText: "Password", image: .icPassword)
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - Initialisers
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        setupKeyboardConfiguration()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Action
    
    @objc
    private func loginButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.login(username: username, password: password)
    }
    
    // MARK: - Private Methods
    
    private func setupBindings() {
        viewModel.onSuccess = { [weak self] in
            self?.navigateToMainScreen()
        }
        viewModel.onFailure = { [weak self] message in
            self?.showError(message)
        }
    }
    
    private func navigateToMainScreen() {
        let mainTabBarViewController = MainTabBarViewController()
        if let window = view.window {
            window.rootViewController = mainTabBarViewController
            window.makeKeyAndVisible()
        }
    }

    private func showError(_ message: String) {
        view.endEditing(true)
        AlertPresenter.presentAlertWithTwoSelections(
            on: self,
            title: message,
            firstActionTitle: "Повторить",
            secondActionTitle: "Отменить") { [weak self] in
                self?.usernameTextField.text = nil
                self?.passwordTextField.text = nil
            }
    }
    
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
    
    // MARK: Keyboard settings
    
    private func setupKeyboardConfiguration() {
        setupKeyboardObservers()
        setupDismissKeyboardGesture()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight
            }
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
        
    @objc
    func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: - extensions

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            loginButtonTapped()
        }
        return true
    }
}
