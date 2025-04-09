//
//  CryptoListViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class CryptoListViewController: UIViewController {

    // MARK: - Private Properties
    
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
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
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
    
    
    // MARK: - Initialisers
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    
    // MARK: - Action
    
    @objc
    private func didTapMoreButton() {
        print("didTapMoreButton")
    }
    
    @objc
    private func didTapSortButton() {
        print("didTapSortButton")
    }
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .wBackgroundMain

        let subviews: [UIView] = [
            titleLabel,
            rightNavBarButton,
            affiliateLabel,
            learnMoreButton,
            imageView,
            backgroundView,
            trendingLabel,
            sortButton
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
            sortButtonConstraints()
        )
    }

    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            titleLabel.heightAnchor.constraint(equalToConstant: 48)
        ]
    }
    
    private func rightNavBarButtonConstraints() -> [NSLayoutConstraint] {
        [
            rightNavBarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            rightNavBarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            rightNavBarButton.heightAnchor.constraint(equalToConstant: 48),
            rightNavBarButton.widthAnchor.constraint(equalToConstant: 48)
        ]
    }
    
    private func affiliateLabelConstraints() -> [NSLayoutConstraint] {
        [
            affiliateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            affiliateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 46),
            affiliateLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
    }
    
    private func learnMoreButtonConstraints() -> [NSLayoutConstraint] {
        [
            learnMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            learnMoreButton.topAnchor.constraint(equalTo: affiliateLabel.bottomAnchor, constant: 12),
            learnMoreButton.heightAnchor.constraint(equalToConstant: 35),
            learnMoreButton.widthAnchor.constraint(equalToConstant: 127)
        ]
    }
    
    private func imageConstraints() -> [NSLayoutConstraint] {
        [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 189),
            imageView.topAnchor.constraint(equalTo: rightNavBarButton.bottomAnchor, constant: 21),
            imageView.widthAnchor.constraint(equalToConstant: 242),
            imageView.heightAnchor.constraint(equalToConstant: 242)
        ]
    }
    
    private func backgroundViewConstraints() -> [NSLayoutConstraint] {
        [
            backgroundView.topAnchor.constraint(equalTo: learnMoreButton.bottomAnchor, constant: 55),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }
    
    private func trendingLabelConstraints() -> [NSLayoutConstraint] {
        [
            trendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            trendingLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 24),
            trendingLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
    }
    
    private func sortButtonConstraints() -> [NSLayoutConstraint] {
        [
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            sortButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 30),
            sortButton.heightAnchor.constraint(equalToConstant: 24),
            sortButton.widthAnchor.constraint(equalToConstant: 24)
        ]
    }
    
}

