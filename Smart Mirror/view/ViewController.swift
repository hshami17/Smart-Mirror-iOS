//
//  ViewController.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 10/31/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var topLeftModule: ModuleImageView!
    @IBOutlet weak var topRightModule: ModuleImageView!
    @IBOutlet weak var topModule: ModuleImageView!
    
    var modules = [Module]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testModule()
        topLeftModule.image = UIImage(named: "weather")
        topRightModule.image = UIImage(named: "clock")
        topModule.image = UIImage(named: "quote")
    }
    
    private func testModule() {
        let module = Module(
            [DictKeys.NAME: "TEST MODULE",
             DictKeys.APIKEY: "TEST KEY",
             DictKeys.POSITION: "TEST POS"]
        )
        modules.append(module!)
    }
    
    //MARK: Actions
    @IBAction func topLeftDetails(_ sender: UITapGestureRecognizer) {
        callSegue(sender)
    }
    
    @IBAction func topRightDetails(_ sender: UITapGestureRecognizer) {
        callSegue(sender)
    }
    
    @IBAction func topDetails(_ sender: UITapGestureRecognizer) {
        callSegue(sender)
    }
    
    private func callSegue(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ModuleDetail", sender: sender)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let moduleDetailController = segue.destination as? ModuleDetailViewController else {
            fatalError("CANNOT DOWNCAST TO ModuleDetailViewController!")
        }
        
        moduleDetailController.loadInfo(module: modules[0])
    }
}
