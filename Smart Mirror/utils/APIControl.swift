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
        
        let urlStr = "https://newsapi.org/v1/articles?source=cnn&sortby=top&apiKey=1dc119526a584abfb70aad792be87582"
        guard let url = URL(string: urlStr) else { fatalError("SHIT") }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print (error!.localizedDescription)
            }
            
            guard let data = data else { fatalError("SHIT") }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
            }
            catch let jsonErr {
                print("Error serializing JSON: \(jsonErr)")
            }
        }.resume()
    }
    
    // TESTING
    private static func loadTestData() {
        var module = Module(type: .WEATHER,
            moduleInfo: [
            .NAME: "Dark Sky",
            .POSITION: PositionStr.TOPLEFT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.WEATHER] = module
        
        module = Module(type: .CLOCK,
            moduleInfo: [
            .NAME: "Clock",
            .POSITION: PositionStr.TOPRIGHT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.CLOCK] = module
        
        module = Module(type: .TASKS,
            moduleInfo: [
            .NAME: "Wunderlist",
            .POSITION: PositionStr.BOTTOMLEFT.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.TASKS] = module
        
        module = Module(type: .NEWS,
            moduleInfo: [
            .NAME: "News",
            .POSITION: PositionStr.BOTTOM.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.NEWS] = module
        
        module = Module(type: .QUOTE,
            moduleInfo: [
            .NAME: "Random Famous Quotes",
            .POSITION: PositionStr.TOP.rawValue,
            .APIKEY: "1234"])
        APIControl.Modules[.QUOTE] = module
    }
}
