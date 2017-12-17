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
        self.title = module?.name
        txtApiKey.text = module?.apikey
        showModuleDetailsForModule()
    }

    private func showModuleDetailsForModule() {
        switch module!.type {
            case .WEATHER:
                print("Show weather controls")
            case .CLOCK:
                print("Show clock controls")
            case .NEWS:
                print("Show news controls")
            case .QUOTE:
                print("Show quote controls")
            case .TASKS:
                print("Show task controls")
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
