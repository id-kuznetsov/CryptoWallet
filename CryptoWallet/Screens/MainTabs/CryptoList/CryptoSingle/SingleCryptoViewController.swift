//
//  SingleCryptoViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import UIKit

final class SingleCryptoViewController: UIViewController {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
//    private var viewModel: SingleCryptoViewModelProtocol
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.icBack, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue
        label.font = FontStyle.medium.font(size: 14)
        label.textAlignment = .center
        label.text = "Etherium (ETH)" // TODO: for test
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue
        label.font = FontStyle.medium.font(size: 28)
        label.textAlignment = .center
        label.text = "$32,128.80" // TODO: for test
        return label
    }()
    
    private lazy var changePriceLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.medium.font(size: 14)
        label.text = "2.5%" // TODO: for test
        label.textColor = .wTextSubtitle
        return label
    }()
    
    private lazy var changePercentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .icArrowUp // TODO: for test
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var changePriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [changePercentImageView, changePriceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var segmentControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl(segments: ["24H", "1W", "1Y", "ALL", "Point"])
         control.translatesAutoresizingMaskIntoConstraints = false
         return control
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .wBackgroundCard1
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var marketStatisticLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue
        label.font = FontStyle.medium.font(size: 20)
        label.textAlignment = .left
        label.text = "Market Statistic"
        return label
    }()
    
    private lazy var marketCapitalizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wTextSubtitle
        label.font = FontStyle.medium.font(size: 14)
        label.textAlignment = .left
        label.text = "Market capitalization"
        return label
    }()
    
    private lazy var marketCapitalizationPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wTextTitle
        label.font = FontStyle.semiBold.font(size: 14)
        label.textAlignment = .left
        label.text = "$231,233"
        return label
    }()
    
    private lazy var circulatingSuplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wTextSubtitle
        label.font = FontStyle.medium.font(size: 14)
        label.textAlignment = .left
        label.text = "Circulating Suply"
        return label
    }()
    
    private lazy var circulatingSuplyPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wTextTitle
        label.font = FontStyle.semiBold.font(size: 14)
        label.textAlignment = .left
        label.text = "114.211 ETH"
        return label
    }()
    
    

    // MARK: - Initialisers
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Action
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .wBackgroundGray1
        
        let subviews = [
            backButton,
            titleLabel,
            priceLabel,
            changePriceStackView,
            segmentControl,
            backgroundView,
            marketStatisticLabel,
            marketCapitalizationLabel,
            marketCapitalizationPriceLabel,
            circulatingSuplyLabel,
            circulatingSuplyPriceLabel
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            backButtonConstraints() +
            titleLabelConstraints() +
            priceLabelConstraints() +
            changePriceStackViewConsraints() +
            segmentControlConstraints() +
            backgroundViewConstraints() +
            marketStatisticLabelConstraints() +
            marketCapitalizationLabelConstraints() +
            marketCapitalizationPriceLabelConstraints() +
            circulatingSuplyLabelConstraints() +
            circulatingSuplyPriceLabelConstraints()
        )
    }
    
    private func backButtonConstraints() -> [NSLayoutConstraint] {
        [
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            backButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.widthAnchor.constraint(equalToConstant: 48)
        ]
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ]
    }
    
    private func priceLabelConstraints() -> [NSLayoutConstraint] {
        [
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ]
    }
    
    private func changePriceStackViewConsraints() -> [NSLayoutConstraint] {
        [
            changePercentImageView.widthAnchor.constraint(equalToConstant: 12),
            changePercentImageView.heightAnchor.constraint(equalToConstant: 12),
            changePriceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePriceStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor)
        ]
    }
    
    private func segmentControlConstraints() -> [NSLayoutConstraint] {
        [
            segmentControl.topAnchor.constraint(equalTo: changePriceStackView.bottomAnchor, constant: 20),
            segmentControl.heightAnchor.constraint(equalToConstant: 56),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
        ]
    }
    
    private func backgroundViewConstraints() -> [NSLayoutConstraint] {
        [
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }
    
    private func marketStatisticLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketStatisticLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25),
            marketStatisticLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25)
        ]
    }
    
    private func marketCapitalizationLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketCapitalizationLabel.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: 15),
            marketCapitalizationLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25)
        ]
    }
    
    private func marketCapitalizationPriceLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketCapitalizationPriceLabel.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: 15),
            marketCapitalizationPriceLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25)
        ]
    }
    
    private func circulatingSuplyLabelConstraints() -> [NSLayoutConstraint] {
        [
            circulatingSuplyLabel.topAnchor.constraint(equalTo: marketCapitalizationLabel.bottomAnchor, constant: 15),
            circulatingSuplyLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25)
        ]
    }
    
    private func circulatingSuplyPriceLabelConstraints() -> [NSLayoutConstraint] {
        [
            circulatingSuplyPriceLabel.topAnchor.constraint(equalTo: marketCapitalizationPriceLabel.bottomAnchor, constant: 15),
            circulatingSuplyPriceLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25)
        ]
    }
    
    
}

// MARK: - extensions

