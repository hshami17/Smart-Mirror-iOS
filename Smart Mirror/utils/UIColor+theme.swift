//
//  UIColor+theme.swift
//  Smart Mirror
//
//  Created by Diego Bustamante on 7/12/19.
//  Copyright © 2019 Hasan Shami. All rights reserved.
//

import UIKit

extension UIColor {
    static let radicalRed = UIColor.rgb(red: 255, green: 45, blue: 85)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}



