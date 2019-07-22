//
//  ViewController.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 10/31/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import UIKit
import Lottie

protocol IPAddressDelegate {
    func reload()
}

class ViewController: UIViewController, IPAddressDelegate {
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
    let animationView : AnimationView = {
        let view = AnimationView(name: "loading")
        view.play()
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.backgroundBehavior = .pauseAndRestore
        return view
    }()
    
    func setupLoadingAnimation() {
        view.addSubview(animationView)
        animationView.anchor(topAnchor: view.topAnchor, bottomAnchor: view.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }

    fileprivate func presentIPAddressEntryViewController() {
        let view = PresentIPAddressEntryViewController()
        let navView = UINavigationController(rootViewController: view)
        navView.modalPresentationStyle = .overCurrentContext
        self.present(navView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodSpaces += [TOPLEFT_BOUNDS, TOPRIGHT_BOUNDS, BOTTOMLEFT_BOUNDS, BOTTOMRIGHT_BOUNDS]
        let ipAddress = UserDefaultManager.getSmartMirrorAPI()
        if (!APIControl.Modules.isEmpty) {
            // Initialize module views
            APIControl.pullConfiguration(ipAddress: ipAddress)
            initModules()
            
            // Place module views onto main view
            for imageView in imageViews {
                if (imageView.onMirror) {
                    self.view.addSubview(imageView)
                }
            }
        } else {
            presentIPAddressEntryViewController()
        }
    }
    
    func reload() {
        //
    }
    
    private func initModules() {
        let weatherModule = ModuleImageView(
            image: UIImage(named: "weather")!,
            module: APIControl.Modules[APINames.DARK_SKY.rawValue]!,
            viewController: self)
        
        let clockModule = ModuleImageView(
            image: UIImage(named: "clock")!,
            module: APIControl.Modules[APINames.CLOCK.rawValue]!,
            viewController: self)
        
        let taskModule = ModuleImageView(
            image: UIImage(named: "tasks")!,
            module: APIControl.Modules[APINames.WUNDERLIST.rawValue]!,
            viewController: self)
        
        // Setup info for this module
        topModule.setupModuleInfo(image: UIImage(named: "quote"), module: APIControl.Modules[APINames.RANDOM_FAMOUS_QUOTES.rawValue]!, viewController: self)
        bottomModule.setupModuleInfo(image: UIImage(named: "news"), module: APIControl.Modules[APINames.NEWS_API.rawValue]!, viewController: self)
        
        // Do not allow pan gestures on certain modules
        topModule.allowPan = false
        bottomModule.allowPan = false
        
        imageViews += [weatherModule, clockModule, taskModule, topModule, bottomModule]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar and status bar on this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//         UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar and status bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        UIApplication.shared.isStatusBarHidden = false
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
