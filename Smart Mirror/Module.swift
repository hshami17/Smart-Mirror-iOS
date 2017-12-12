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
    var type: TypeKeys
    var name: String
    var position: String
    var apikey: String
    var onMirror = true
    
    init(type: TypeKeys, moduleInfo: [ConfigKeys: String]) {
        self.type = type
        self.name = moduleInfo[.NAME]!
        self.position = moduleInfo[.POSITION]!
        self.apikey = moduleInfo[.APIKEY]!
    }
}
