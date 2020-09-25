//
//  DetailsTextField.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 6/21/19.
//  Copyright © 2019 Hasan Shami. All rights reserved.
//

import Foundation
import UIKit

class DetailsTextField : UITextField {
    let textSize : CGFloat = 18
    init(label: String, text: String, placeholder: String, icon: UIImage) {
        super.init(frame: CGRect())
        setupAPITextfield(placeholder: placeholder, text: text)
        setupLabel(text: label, icon: icon)
    }
    
    func setupAPITextfield(placeholder: String, text: String) {
        let apiAttributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: textSize, weight: .ultraLight)])
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.layer.cornerRadius = 4
        self.attributedText = apiAttributedText
        self.placeholder = placeholder
        self.clearButtonMode = .whileEditing
    }
    
    func setupLabel(text: String, icon: UIImage) {
        let textLabel = UITextField()
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.radicalRed, NSAttributedString.Key.font : UIFont.systemFont(ofSize: textSize, weight: .bold)])
        let iconImageView = UIImageView(image: icon)
        iconImageView.contentMode = .left
        if let size = iconImageView.image?.size {
            iconImageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height) // Adds padding to icon
        }
        textLabel.leftView = iconImageView
        textLabel.leftViewMode = UITextField.ViewMode.always
        textLabel.attributedText = attributedText
        self.addSubview(textLabel)
        textLabel.anchor(topAnchor: nil, bottomAnchor: self.topAnchor, leadingAnchor: self.leadingAnchor, trailingAnchor: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 38)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
       self.init(coder: aDecoder)
    }
}
