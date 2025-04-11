//
//  CustomTextField.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 09.04.2025.
//

import UIKit

final class CustomTextField: UITextField {
    
    private let textPadding = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 20)
    
    init(backgroundText: String, image: UIImage? = nil) {
        super.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(
            string: backgroundText,
            attributes: [
                .foregroundColor: UIColor.wTextSubtitle,
                .font: FontStyle.regular.font(size: 15)
            ]
        )
        backgroundColor = .white
        textColor = .wTextTitle
        font = FontStyle.regular.font(size: 15)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = .whileEditing
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            
            let containerWidth: CGFloat = 24 + 20
            let container = UIView(frame: CGRect(x: 10, y: 0, width: containerWidth, height: 44))
            imageView.center = CGPoint(x: 22, y: container.frame.height / 2)
            container.addSubview(imageView)
            
            leftView = container
            leftViewMode = .always
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
