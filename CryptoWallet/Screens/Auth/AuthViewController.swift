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
            authImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.imageSideInset),
            authImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.imageSideInset),
            authImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.imageTopInset),
            authImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageHeight)
        ]
    }

    private func textFieldsStackViewConstraints() -> [NSLayoutConstraint] {
        [
            usernameTextField.heightAnchor.constraint(equalToConstant: LayoutConstants.textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: LayoutConstants.textFieldHeight),

            textFieldsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.textFieldSideInset),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.textFieldSideInset),
            textFieldsStackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -LayoutConstants.textFieldBottomSpacing)
        ]
    }

    private func loginButtonConstraints() -> [NSLayoutConstraint] {
        [
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.buttonSideInset),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.buttonSideInset),
            loginButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutConstants.buttonBottomInset)
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

private enum LayoutConstants {
    static let imageSideInset: CGFloat = 44
    static let imageTopInset: CGFloat = 13
    static let imageHeight: CGFloat = 287

    static let textFieldHeight: CGFloat = 55
    static let textFieldSideInset: CGFloat = 25
    static let textFieldBottomSpacing: CGFloat = 25

    static let buttonSideInset: CGFloat = 25
    static let buttonHeight: CGFloat = 55
    static let buttonBottomInset: CGFloat = 133
}
