//
//  Module.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/3/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import Foundation

class Module {
    //MARK: Properties
    var name: String
    var position: String
    var apikey: String
    var onMirror = true
    
    init(moduleInfo: [ConfigKeys: String]) {
        self.name = moduleInfo[ConfigKeys.NAME]!
        self.position = moduleInfo[ConfigKeys.POSITION]!
        self.apikey = moduleInfo[ConfigKeys.APIKEY]!
    }
}
