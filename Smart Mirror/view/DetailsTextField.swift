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
    
    init(label: String, text: String, placeholder: String) {
        super.init(frame: CGRect())
        
        self.text = text
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 38))
        textLabel.text = label + ":"
        self.leftView = textLabel
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
       self.init(coder: aDecoder)
    }
}
