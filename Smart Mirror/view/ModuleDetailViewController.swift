//
//  ModuleDetailViewController.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/1/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import UIKit

class ModuleDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var txtApiKey: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    var module: Module? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        txtApiKey.text = module?.key
        showModuleDetailsForModule()
    }

    private func showModuleDetailsForModule() {
        switch module!.name {
            case APINames.DARK_SKY.rawValue:
                 self.title = "Dark Sky"
                print("Show weather controls")
            case APINames.CLOCK.rawValue:
                 self.title = "Clock"
                print("Show clock controls")
            case APINames.NEWS_API.rawValue:
                 self.title = "News API"
                print("Show news controls")
            case APINames.RANDOM_FAMOUS_QUOTES.rawValue:
                 self.title = "Random Famous Quotes"
                print("Show quote controls")
            case APINames.WUNDERLIST.rawValue:
                 self.title = "Wunderlist"
                print("Show task controls")
            default:
                print("UNKNOWN MODULE")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
