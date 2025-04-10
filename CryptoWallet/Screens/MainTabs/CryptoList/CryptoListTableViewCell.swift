//
//  CryptoListTableViewCell.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import UIKit

final class CryptoListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CryptoListTableViewCell"

    // MARK: - Private Properties

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.medium.font(size: 18)
        label.textColor = .wTextTitle
        return label
    }()
    
    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.medium.font(size: 14)
        label.textColor = .wTextSubtitle
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.medium.font(size: 18)
        label.textColor = .wTextTitle
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
        return imageView
    }()
    
    // MARK: - Initialisers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        nameLabel.text = nil
        shortNameLabel.text = nil
        priceLabel.text = nil
        changePriceLabel.text = nil
        changePercentImageView.image = nil
    }
    
    // MARK: - Public Methods

    func setupCell(with cryptoCurrency: CryptoCurrency) {
        iconImageView.image = cryptoCurrency.image
        nameLabel.text = cryptoCurrency.name
        shortNameLabel.text = cryptoCurrency.symbol
        priceLabel.text = formatCurrency(cryptoCurrency.priceUSD)
        changePriceLabel.text = String(format: "%.1f", cryptoCurrency.percentChange24h) + "%"
        setChangePercentImage(for: cryptoCurrency.percentChange24h)
    }
    
    // MARK: - Private Methods

    private func setupCellUI() {
        contentView.backgroundColor = .wBackgroundGray2
      
        let subviews = [iconImageView, nameLabel, shortNameLabel ,priceLabel, changePriceLabel, changePercentImageView]
        subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setChangePercentImage(for percentChange: Double) {
        changePercentImageView.image = percentChange >= 0 ? .icArrowUp : .icArrowDown
    }

    private func formatCurrency(_ amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "en_US")
        
        if let formattedAmount = numberFormatter.string(from: NSNumber(value: amount)) {
            return "$" + formattedAmount
        }
        
        return "$0.00"
    }
    
    // MARK: Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            iconImageViewConstraints() +
            nameLabelConstraints() +
            shortNameLabelConstraints() +
            priceLabelConstraints() +
            changePriceLabelConstraints() +
            changePercentImageViewConstraints()
        )
    }
    
    private func iconImageViewConstraints() -> [NSLayoutConstraint] {
        [
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        [
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 19),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 27)
        ]
    }
    
    private func shortNameLabelConstraints() -> [NSLayoutConstraint] {
        [
            shortNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 19),
            shortNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            shortNameLabel.heightAnchor.constraint(equalToConstant: 21)
        ]
    }
    
    private func priceLabelConstraints() -> [NSLayoutConstraint] {
        [
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ]
    }
    
    private func changePriceLabelConstraints() -> [NSLayoutConstraint] {
        [
            changePriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            changePriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3)
        ]
    }
    
    private func changePercentImageViewConstraints() -> [NSLayoutConstraint] {
        [
            changePercentImageView.trailingAnchor.constraint(equalTo: changePriceLabel.leadingAnchor, constant: -5),
            changePercentImageView.centerYAnchor.constraint(equalTo: changePriceLabel.centerYAnchor)
        ]
    }
}
