//
//  Module.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/3/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import Foundation

class Module: Decodable {
    // General fields
    var name: String
    var position: String
    var key: String
    
    // Dark Sky
    var zipcode: String?
    var zipcodekey: String?
        
    // Wunderlist
    var clientid: String?
    var listid: String?
    
    // News API
    var source: String?
    var sortBy: String?
    
    // Random Famous Quotes
    var category: String?
    
    // Clock
    
}
