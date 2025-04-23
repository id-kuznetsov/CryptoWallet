//
//  SingleCryptoViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import UIKit

final class SingleCryptoViewController: UIViewController {

    // MARK: - Private Properties
    
    private var viewModel: SingleCryptoViewModelProtocol
    
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
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue
        label.font = FontStyle.medium.font(size: 28)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var changePriceLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.medium.font(size: 14)
        label.textColor = .wTextSubtitle
        return label
    }()
    
    private lazy var changePercentImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    init(viewModel: SingleCryptoViewModelProtocol) {
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
    }
    
    // MARK: - Action
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        let coin = viewModel.coin
        titleLabel.text = "\(coin.name) (\(coin.symbol))"
        priceLabel.text = "$" + coin.priceUSD.formatCurrency(fractionDigits: 5)
        changePriceLabel.text = String(format: "%.1f", abs(coin.percentChange24h)) + "%"
        setChangePercentImage(for: coin.percentChange24h)
        marketCapitalizationPriceLabel.text = "$" + coin.marketCapUSD.formatCurrency(fractionDigits: 0)
        circulatingSuplyPriceLabel.text = coin.circulatingSupply.formatCurrency(fractionDigits: 0) + " \(coin.symbol)"
    }
    
    private func setChangePercentImage(for percentChange: Double) {
        changePercentImageView.image = percentChange >= 0 ? .icArrowUp : .icArrowDown
    }

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
            changePriceStackViewConstraints() +
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
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.backButtonTop),
            backButton.heightAnchor.constraint(equalToConstant: LayoutConstants.backButtonSize),
            backButton.widthAnchor.constraint(equalToConstant: LayoutConstants.backButtonSize)
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
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.titleToPriceSpacing)
        ]
    }

    private func changePriceStackViewConstraints() -> [NSLayoutConstraint] {
        [
            changePercentImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.changeIconSize),
            changePercentImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.changeIconSize),
            changePriceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePriceStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: LayoutConstants.priceToChangeSpacing)
        ]
    }

    private func segmentControlConstraints() -> [NSLayoutConstraint] {
        [
            segmentControl.topAnchor.constraint(equalTo: changePriceStackView.bottomAnchor, constant: LayoutConstants.changeStackToSegmentSpacing),
            segmentControl.heightAnchor.constraint(equalToConstant: LayoutConstants.segmentHeight),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sideInset),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sideInset)
        ]
    }

    private func backgroundViewConstraints() -> [NSLayoutConstraint] {
        [
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.backgroundViewHeight),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }

    private func marketStatisticLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketStatisticLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: LayoutConstants.statTopSpacing),
            marketStatisticLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideInset)
        ]
    }

    private func marketCapitalizationLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketCapitalizationLabel.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: LayoutConstants.statVerticalSpacing),
            marketCapitalizationLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideInset)
        ]
    }

    private func marketCapitalizationPriceLabelConstraints() -> [NSLayoutConstraint] {
        [
            marketCapitalizationPriceLabel.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: LayoutConstants.statVerticalSpacing),
            marketCapitalizationPriceLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideInset)
        ]
    }

    private func circulatingSuplyLabelConstraints() -> [NSLayoutConstraint] {
        [
            circulatingSuplyLabel.topAnchor.constraint(equalTo: marketCapitalizationLabel.bottomAnchor, constant: LayoutConstants.statVerticalSpacing),
            circulatingSuplyLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideInset)
        ]
    }

    private func circulatingSuplyPriceLabelConstraints() -> [NSLayoutConstraint] {
        [
            circulatingSuplyPriceLabel.topAnchor.constraint(equalTo: marketCapitalizationPriceLabel.bottomAnchor, constant: LayoutConstants.statVerticalSpacing),
            circulatingSuplyPriceLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideInset)
        ]
    }
}

private extension SingleCryptoViewController {
    enum LayoutConstants {
        static let sideInset: CGFloat = 25
        static let backButtonSize: CGFloat = 48
        static let backButtonTop: CGFloat = 57
        static let titleToPriceSpacing: CGFloat = 20
        static let priceToChangeSpacing: CGFloat = 0
        static let changeStackToSegmentSpacing: CGFloat = 20
        static let segmentHeight: CGFloat = 56
        static let backgroundViewHeight: CGFloat = 160
        static let statTopSpacing: CGFloat = 25
        static let statVerticalSpacing: CGFloat = 15
        static let changeIconSize: CGFloat = 12
    }
}
