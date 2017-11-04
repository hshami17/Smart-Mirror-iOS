//
//  APIControl.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/4/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import Foundation

class APIControl {
    static var Modules = [TypeKeys: Module]()
    
    static func pullConfiguration() {
        APIControl.loadTestData()
    }
    
    // TESTING
    private static func loadTestData() {
        var module = Module(moduleInfo: [
            .NAME: "Dark Sky",
            .POSITION: PositionStr.TOPLEFT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.WEATHER] = module
        
        module = Module(moduleInfo: [
            .NAME: "Clock",
            .POSITION: PositionStr.TOPRIGHT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.CLOCK] = module
        
        module = Module(moduleInfo: [
            .NAME: "Wunderlist",
            .POSITION: PositionStr.BOTTOMLEFT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.TASKS] = module
        
        module = Module(moduleInfo: [
            .NAME: "News",
            .POSITION: PositionStr.BOTTOM.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.NEWS] = module
        
        module = Module(moduleInfo: [
            .NAME: "Random Famous Quotes",
            .POSITION: PositionStr.TOP.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.QUOTE] = module
    }
}
