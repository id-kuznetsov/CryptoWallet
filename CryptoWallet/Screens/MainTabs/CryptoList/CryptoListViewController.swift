//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class CryptoListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: CryptoListViewModelProtocol
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontStyle.semiBold.font(size: 32)
        label.textAlignment = .left
        label.text = "Home"
        label.sizeToFit()
        return label
    }()
    
    private lazy var rightNavBarButton: UIButton = {
        let button = UIButton()
        button.setImage(.icDots, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var moreOptionsView: MoreOptionsView = {
        let view = MoreOptionsView()
        view.onUpdateButtonTapped = { [weak self] in
            self?.didTapUpdateButton()
        }
        view.onExitButtonTapped = { [weak self] in
            self?.didTapExitButton()
        }
        return view
    }()
    
    private lazy var affiliateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontStyle.medium.font(size: 20)
        label.textAlignment = .left
        label.text = "Affiliate program"
        return label
    }()
    
    private lazy var learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(.wTextTitle, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = FontStyle.semiBold.font(size: 14)
        button.layer.cornerRadius = 17.5
        button.addTarget(self, action: #selector(didTapLearnMoreButton), for: .touchUpInside)
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .home
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .wBackgroundGray2
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var trendingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue
        label.font = FontStyle.medium.font(size: 20)
        label.textAlignment = .left
        label.text = "Trending"
        return label
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(.icSort, for: .normal)
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CryptoListTableViewCell.self, forCellReuseIdentifier: CryptoListTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.backgroundColor = .wBackgroundGray2
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .wBlue
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Initialisers
    
    init(viewModel: CryptoListViewModelProtocol) {
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
        
        bindViewModel()
        viewModel.loadCoins()
    }
    
    // MARK: - Action
    
    @objc
    private func didTapMoreButton() {
        toggleMoreOptionsView()
    }
    
    private func didTapUpdateButton() {
        viewModel.loadCoins()
        moreOptionsView.removeFromSuperview()
    }
    
    private func didTapExitButton() {
        viewModel.logout()
        moreOptionsView.removeFromSuperview()
        
        if let window = view.window {
            let authViewModel = AuthViewModel()
            let authViewController = AuthViewController(viewModel: authViewModel)
            window.rootViewController = authViewController
            window.makeKeyAndVisible()
        }
    }
    
    @objc
    private func didTapLearnMoreButton() {
        print("didTapLearnMoreButton")
    }
    
    @objc
    private func didTapSortButton() {
        AlertPresenter.presentSortAlert(
            on: self,
            sortOptions: [.increasing, .decreasing]
        ) { [weak self] selectedSortOption in
            self?.viewModel.sortItems(by: selectedSortOption)
        }
    }

    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.onLoadingChange = { [weak self] isLoading in
            isLoading ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
        }
        
        viewModel.onCoinsUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    private func toggleMoreOptionsView() {
        if moreOptionsView.superview == nil {
            view.addSubview(moreOptionsView)
            
            moreOptionsView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    moreOptionsView.trailingAnchor.constraint(equalTo: rightNavBarButton.trailingAnchor, constant: -4),
                    moreOptionsView.topAnchor.constraint(equalTo: rightNavBarButton.bottomAnchor, constant: 8),
                    moreOptionsView.widthAnchor.constraint(equalToConstant: 157),
                    moreOptionsView.heightAnchor.constraint(equalToConstant: 102)
                ]
            )
            moreOptionsView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.moreOptionsView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.moreOptionsView.alpha = 0
            }) { _ in
                self.moreOptionsView.removeFromSuperview()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .wBackgroundMain
        navigationController?.navigationBar.isHidden = true
        let subviews: [UIView] = [
            titleLabel,
            rightNavBarButton,
            affiliateLabel,
            learnMoreButton,
            imageView,
            backgroundView,
            trendingLabel,
            sortButton,
            tableView,
            spinner
        ]
        subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            titleLabelConstraints() +
            rightNavBarButtonConstraints() +
            affiliateLabelConstraints() +
            learnMoreButtonConstraints() +
            imageConstraints() +
            backgroundViewConstraints() +
            trendingLabelConstraints() +
            sortButtonConstraints() +
            tableViewConstraints() +
            spinnerConstraints()
        )
    }
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.topInset),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.titleHeight)
        ]
    }

    private func rightNavBarButtonConstraints() -> [NSLayoutConstraint] {
        [
            rightNavBarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sideInset),
            rightNavBarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.topInset),
            rightNavBarButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonSize),
            rightNavBarButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonSize)
        ]
    }

    private func affiliateLabelConstraints() -> [NSLayoutConstraint] {
        [
            affiliateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            affiliateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.affiliateTopSpacing),
            affiliateLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.affiliateHeight)
        ]
    }

    private func learnMoreButtonConstraints() -> [NSLayoutConstraint] {
        [
            learnMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            learnMoreButton.topAnchor.constraint(equalTo: affiliateLabel.bottomAnchor, constant: LayoutConstants.learnMoreTopSpacing),
            learnMoreButton.heightAnchor.constraint(equalToConstant: LayoutConstants.learnMoreHeight),
            learnMoreButton.widthAnchor.constraint(equalToConstant: LayoutConstants.learnMoreWidth)
        ]
    }

    private func imageConstraints() -> [NSLayoutConstraint] {
        [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.imageLeading),
            imageView.topAnchor.constraint(equalTo: rightNavBarButton.bottomAnchor, constant: LayoutConstants.imageTopSpacing),
            imageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageSize)
        ]
    }

    private func backgroundViewConstraints() -> [NSLayoutConstraint] {
        [
            backgroundView.topAnchor.constraint(equalTo: learnMoreButton.bottomAnchor, constant: LayoutConstants.backgroundTopSpacing),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }

    private func trendingLabelConstraints() -> [NSLayoutConstraint] {
        [
            trendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            trendingLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: LayoutConstants.trendingTopSpacing),
            trendingLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.trendingHeight)
        ]
    }

    private func sortButtonConstraints() -> [NSLayoutConstraint] {
        [
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sideInset),
            sortButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: LayoutConstants.sortButtonTopSpacing),
            sortButton.heightAnchor.constraint(equalToConstant: LayoutConstants.sortButtonSize),
            sortButton.widthAnchor.constraint(equalToConstant: LayoutConstants.sortButtonSize)
        ]
    }

    private func tableViewConstraints() -> [NSLayoutConstraint] {
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: LayoutConstants.tableViewTopSpacing),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }

    private func spinnerConstraints() -> [NSLayoutConstraint] {
        [
            spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ]
    }

    
    private func showErrorAlert(message: String) {
        AlertPresenter.presentAlertWithTwoSelections(
            on: self,
            title: message,
            firstActionTitle: "Ок",
            secondActionTitle: "Повторить"
        ) { [weak self] in
            self?.viewModel.loadCoins()
        }
    }
    
}

// MARK: - Extension

extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coinsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CryptoListTableViewCell else { return UITableViewCell() }
        
        guard let cryptoCurrency = viewModel.getCoin(at: indexPath.row) else { return UITableViewCell() }
        
        cell.setupCell(with: cryptoCurrency)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
}

extension CryptoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCoin = viewModel.getCoin(at: indexPath.row) else { return }
        let singleCryptoViewModel = SingleCryptoViewModel(coin: selectedCoin)
        let singleCoinViewController = SingleCryptoViewController(viewModel: singleCryptoViewModel)
        navigationController?.pushViewController(singleCoinViewController, animated: true)
    }
}

// MARK: Layout

private enum LayoutConstants {
    static let sideInset: CGFloat = 25
    static let topInset: CGFloat = 57
    static let titleHeight: CGFloat = 48
    static let buttonSize: CGFloat = 48
    static let affiliateTopSpacing: CGFloat = 46
    static let affiliateHeight: CGFloat = 30
    static let learnMoreTopSpacing: CGFloat = 12
    static let learnMoreHeight: CGFloat = 35
    static let learnMoreWidth: CGFloat = 127
    static let imageTopSpacing: CGFloat = 21
    static let imageLeading: CGFloat = 189
    static let imageSize: CGFloat = 242
    static let backgroundTopSpacing: CGFloat = 55
    static let trendingTopSpacing: CGFloat = 24
    static let trendingHeight: CGFloat = 30
    static let sortButtonTopSpacing: CGFloat = 30
    static let sortButtonSize: CGFloat = 24
    static let tableViewTopSpacing: CGFloat = 16
}


