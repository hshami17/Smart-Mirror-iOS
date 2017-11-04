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
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var name: UITextField!
    var module: Module? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
    }

    private func loadInfo() {
        name.text = module?.name
    }
    
    //MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        }
        else {
            print("ISSUE TRYING TO CANCEL")
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
