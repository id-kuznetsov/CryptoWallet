//
//  CustomSegmentedControl.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import UIKit

final class CustomSegmentedControl: UIView {
    
    // MARK: - Public Properties
    
    var segments: [String] {
        didSet {
            configureButtons()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSelection(animated: true)
            onSegmentChange?(selectedIndex)
        }
    }
    
    var onSegmentChange: ((Int) -> Void)?
    
    // MARK: - Private Properties
    
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    private let selectorView = UIView()
    
    // MARK: - Initialisers
    
    init(segments: [String]) {
        self.segments = segments
        super.init(frame: .zero)
        setupView()
        configureButtons()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectorFrame(animated: false)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .wSegment
        layer.cornerRadius = 30
        layer.masksToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(selectorView)
        addSubview(stackView)
        
        selectorView.layer.cornerRadius = 25
        selectorView.backgroundColor = .white
        selectorView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureButtons() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, title) in segments.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = FontStyle.medium.font(size: 14)
            button.tintColor = .clear
            button.setTitleColor(.wTextSubtitle, for: .normal)
            button.setTitleColor(.wBlue, for: .selected)
            button.tag = index
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 30
            button.layer.masksToBounds = true
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        layoutIfNeeded()
        updateSelectorFrame(animated: false)
        updateSelection(animated: false)
    }
    
    private func updateSelection(animated: Bool) {
        for (index, button) in buttons.enumerated() {
            button.isSelected = (index == selectedIndex)
        }
        updateSelectorFrame(animated: animated)
    }
    
    private func updateSelectorFrame(animated: Bool) {
        guard selectedIndex < buttons.count else { return }
        let selectedButton = buttons[selectedIndex]
        
        let newFrame = selectedButton.frame.insetBy(dx: 4, dy: 4) 
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                self.selectorView.frame = newFrame
            }
        } else {
            selectorView.frame = newFrame
        }
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
