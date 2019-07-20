//
//  UserDefaultManager.swift
//  Smart Mirror
//
//  Created by Diego Bustamante on 7/14/19.
//  Copyright © 2019 Hasan Shami. All rights reserved.
//

import UIKit

struct UserDefaultManager {
    static let shared = UserDefaultManager()
    static let apiKey = "apiKey"
}

extension UserDefaultManager {
    static func setSmartMirrorAPI(API: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: API)
        UserDefaults.standard.set(data, forKey: self.apiKey)
    }
    
    static func getSmartMirrorAPI() -> String{
        guard let data = UserDefaults.standard.data(forKey: self.apiKey) else { return "" }
        guard let API = NSKeyedUnarchiver.unarchiveObject(with: data) as? String else { return "" }
        return API
    }
    
    static func clearSmartMirrorAPI() {
        // Remove from user defaults
        UserDefaults.standard.removeObject(forKey: self.apiKey)
    }
}
