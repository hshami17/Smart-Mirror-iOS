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
        let urlStr = "http://10.0.0.188:8080/api/getmirror"
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
                    print("SETTING MODULE: \(module.name)")
                    APIControl.Modules[module.name] = module
                }
            }
            catch let jsonErr {
                print("Error serializing JSON: \(jsonErr)")
            }
        }.resume()
    }
    
    static func moduleUpdate(_ module: Module) {
        
    }
}
