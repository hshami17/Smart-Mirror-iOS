//
//  CenterPoints.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/4/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import Foundation
import UIKit

class Positions {
    static let TOPLEFT_CENTER = CGPoint(x: 91.0, y: 138.5)
    static let TOPRIGHT_CENTER = CGPoint(x: UIScreen.main.bounds.width - 90.0, y: 138.5)
    static let BOTTOMLEFT_CENTER = CGPoint(x: 91.0, y: 361.5)
    static let BOTTOMRIGHT_CENTER = CGPoint(x: UIScreen.main.bounds.width - 90.0, y: 361.5)
}

enum PositionStr : String {
    case TOP = "top"
    case TOPRIGHT = "topRight"
    case TOPLEFT = "topLeft"
    case BOTTOMRIGHT = "bottomRight"
    case BOTTOMLEFT = "bottomLeft"
    case BOTTOM = "bottom"
    case NONE = "-"
}
