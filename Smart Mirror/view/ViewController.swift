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
    @IBOutlet weak var topModule: ModuleImageView!
    @IBOutlet weak var bottomModule: ModuleImageView!
    
    let TOPLEFT_BOUNDS = CGRect(
        x: Positions.TOPLEFT_CENTER.x - (50 / 2),
        y: Positions.TOPLEFT_CENTER.y - (50 / 2),
        width: 50,
        height: 50
    )
    
    let TOPRIGHT_BOUNDS = CGRect(
        x: Positions.TOPRIGHT_CENTER.x - (50 / 2),
        y: Positions.TOPRIGHT_CENTER.y - (50 / 2),
        width: 50,
        height: 50
    )
    
    let BOTTOMLEFT_BOUNDS = CGRect(
        x: Positions.BOTTOMLEFT_CENTER.x - (50 / 2),
        y: Positions.BOTTOMLEFT_CENTER.y - (50 / 2),
        width: 50,
        height: 50
    )
    
    let BOTTOMRIGHT_BOUNDS = CGRect(
        x: Positions.BOTTOMRIGHT_CENTER.x - (50 / 2),
        y: Positions.BOTTOMRIGHT_CENTER.y - (50 / 2),
        width: 50,
        height: 50
    )
    
    var goodSpaces = [CGRect]()
    var imageViews = [ModuleImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // TEST CONFIGS
        let weatherModule = ModuleImageView(
            image: UIImage(named: "weather")!,
            module: APIControl.Modules[.WEATHER]!,
            originCenter: Positions.TOPLEFT_CENTER,
            viewController: self)
        
        let clockModule = ModuleImageView(
            image: UIImage(named: "clock")!,
            module: APIControl.Modules[.CLOCK]!,
            originCenter: Positions.TOPRIGHT_CENTER,
            viewController: self)
        
        let taskModule = ModuleImageView(
            image: UIImage(named: "tasks")!,
            module: APIControl.Modules[.TASKS]!,
            originCenter: Positions.BOTTOMLEFT_CENTER,
            viewController: self)
        
        self.view.addSubview(weatherModule)
        self.view.addSubview(clockModule)
        self.view.addSubview(taskModule)
        
        // Setup info for this module
        topModule.setupModuleInfo(image: UIImage(named: "quote"), module: APIControl.Modules[.QUOTE]!, viewController: self)
        bottomModule.setupModuleInfo(image: UIImage(named: "news"), module: APIControl.Modules[.NEWS]!, viewController: self)
        
        // Do not allow pan gestures on certain modules
        topModule.allowPan = false
        bottomModule.allowPan = false
        
        imageViews += [weatherModule, clockModule, taskModule, topModule, bottomModule]
        goodSpaces += [TOPLEFT_BOUNDS, TOPRIGHT_BOUNDS, BOTTOMLEFT_BOUNDS, BOTTOMRIGHT_BOUNDS]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar and status bar on this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar and status bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.isStatusBarHidden = false
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
        moduleDetailController.module = tapGesture.module!
    }
}
