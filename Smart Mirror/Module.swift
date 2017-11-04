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
    
    init?(_ moduleInfo: [DictKeys: String]) {
        self.name = moduleInfo[DictKeys.NAME]!
        self.position = moduleInfo[DictKeys.POSITION]!
        self.apikey = moduleInfo[DictKeys.APIKEY]!
    }
}
