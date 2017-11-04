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
    @IBOutlet weak var bottomLeftModule: ModuleImageView!
    @IBOutlet weak var bottomRightModule: ModuleImageView!
    @IBOutlet weak var bottomModule: ModuleImageView!

//    var modules = [TypeKeys: Module]()
    
    let TOPRIGHT_CENTER = CGPoint(x: 323.0, y: 138.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup info for this module
        topLeftModule.setupModuleInfo(image: UIImage(named: "weather"), moduleKey: .WEATHER, viewController: self)
        topRightModule.setupModuleInfo(image: UIImage(named: "clock"), moduleKey: .CLOCK, viewController: self)
        topModule.setupModuleInfo(image: UIImage(named: "quote"), moduleKey: .QUOTE, viewController: self)
        bottomLeftModule.setupModuleInfo(image: UIImage(named: "tasks"), moduleKey: .TASKS, viewController: self)
        bottomModule.setupModuleInfo(image: UIImage(named: "news"), moduleKey: .NEWS, viewController: self)
        
        // Do not allow pan gestures on certain modules
        topModule.allowPan = false
        bottomModule.allowPan = false
        bottomRightModule.allowPan = false
        
        // Top right module being strange with center point
        topRightModule.originCenter = topRightModule.center
    }

    func callSegue(sender: ModuleTap) {
        performSegue(withIdentifier: "ModuleDetail", sender: sender)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Unwrap ModuleDetailViewController from segue destination
        guard let moduleDetailController = segue.destination as? ModuleDetailViewController else {
            fatalError("CANNOT DOWNCAST TO ModuleDetailViewController!")
        }
        
        // Unwrap ModuleTap from sender
        guard let tapGesture = sender as? ModuleTap else {
            fatalError("COULD NOT DOWNCAST TAP TO MODULETAP")
        }
        
        // Load module info from key provided by sender
        let key = tapGesture.moduleType!
        moduleDetailController.module = APIControl.Modules[key]
    }
}
