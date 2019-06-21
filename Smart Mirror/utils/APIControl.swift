//
//  APIControl.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/4/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import Foundation

class APIControl {
    static var Modules = [String: Module]()
    
    static func pullConfiguration() {
        let urlStr = "http://192.168.1.142:8080/api/getmirror" // TODO: Have a window/entry for user to enter the web service address
        guard let url = URL(string: urlStr) else { fatalError("ERROR CREATING URL OBJECT") }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print (error!.localizedDescription)
            }

            guard let jsonData = data else { fatalError("ERROR UNWRAPPING JSON DATA") }

            do {
                // Parse JSON data
                let moduleConfigs = try JSONDecoder().decode([Module].self, from: jsonData)
                
                // Save parsed data into module list
                for module in moduleConfigs {
                    APIControl.Modules[module.name] = module
                }
            }
            catch let jsonErr {
                print("Error deserializing JSON: \(jsonErr)")
            }
        }.resume()
    }
    
    static func updateModule(_ module: Module) {
        // TODO: Send POST request to web server of update Module info
    }
}
