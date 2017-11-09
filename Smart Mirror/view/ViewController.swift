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
//    @IBOutlet weak var topRightModule: ModuleImageView!
    @IBOutlet weak var topModule: ModuleImageView!
//    @IBOutlet weak var bottomLeftModule: ModuleImageView!
//    @IBOutlet weak var bottomRightModule: ModuleImageView!
    @IBOutlet weak var bottomModule: ModuleImageView!
    
    var imageViews = [ModuleImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TEST CONFIGS
        let weatherModule = ModuleImageView(
            image: UIImage(named: "weather")!,
            moduleKey: .WEATHER,
            originCenter: Positions.TOPLEFT_CENTER,
            viewController: self)
        
        let clockModule = ModuleImageView(
            image: UIImage(named: "clock")!,
            moduleKey: .CLOCK,
            originCenter: Positions.TOPRIGHT_CENTER,
            viewController: self)
        
        let taskModule = ModuleImageView(
            image: UIImage(named: "tasks")!,
            moduleKey: .TASKS,
            originCenter: Positions.BOTTOMLEFT_CENTER,
            viewController: self)
        
        self.view.addSubview(weatherModule)
        self.view.addSubview(clockModule)
        self.view.addSubview(taskModule)
        
        // Setup info for this module
        topModule.setupModuleInfo(image: UIImage(named: "quote"), moduleKey: .QUOTE, viewController: self)
        bottomModule.setupModuleInfo(image: UIImage(named: "news"), moduleKey: .NEWS, viewController: self)
        
        // Do not allow pan gestures on certain modules
        topModule.allowPan = false
        bottomModule.allowPan = false
        
        imageViews += [weatherModule, clockModule, taskModule, topModule, bottomModule]
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
