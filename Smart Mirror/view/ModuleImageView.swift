//
//  ModuleImageView.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 10/31/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import UIKit

class ModuleImageView: UIImageView {
    //MARK: Properties
    var moduleKey: TypeKeys!
    var originCenter: CGPoint!
    var viewController: ViewController!
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!
    var allowPan = true
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        originCenter = self.center
        setupPanGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        originCenter = self.center
        setupPanGesture()
    }
    
    func setupModuleInfo(image: UIImage?, moduleKey: TypeKeys, viewController: ViewController) {
        self.image = image
        self.moduleKey = moduleKey
        self.viewController = viewController
    }
    
    //MARK: Private Methods
    private func setupPanGesture() {
        // Scale image accordng to UIImageView size
        self.contentMode = UIViewContentMode.scaleAspectFit
        self.isUserInteractionEnabled = true
        
        // Setup pan gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ModuleImageView.panGesture(gesture:)))
        pan.maximumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        self.addGestureRecognizer(pan)
        
        // Setup tap gesture
        let tap = ModuleTap(target: self, action: #selector(ModuleImageView.tapGesture(gesture:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    private func snapBackToOrigin() {
        animator = UIDynamicAnimator(referenceView: viewController.view)
        snap = UISnapBehavior(item: self, snapTo: originCenter)
        snap.damping = 1.0
        animator.addBehavior(snap)
    }
    
    //MARK: Actions
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        if !allowPan {return}
        switch gesture.state {
            case UIGestureRecognizerState.began, UIGestureRecognizerState.changed:
                // Move the view with the pan
                let translation = gesture.translation(in: self)
                gesture.view!.center = CGPoint(
                    x: gesture.view!.center.x + translation.x,
                    y: gesture.view!.center.y + translation.y
                )
                gesture.setTranslation(CGPoint(x: 0, y: 0), in: self)
            case UIGestureRecognizerState.ended:
                // If not in original center, snap back
                if gesture.view!.center != originCenter {
                    snapBackToOrigin()
                }
            default:
                print("NO PAN GESTURE STATES MATCHED")
        }
    }
    
    @objc func tapGesture(gesture: ModuleTap) {
        if self.image != nil {
            gesture.moduleType = self.moduleKey
            viewController.callSegue(sender: gesture)
        }
    }
}
