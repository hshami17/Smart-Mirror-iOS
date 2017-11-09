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
    var viewController: ViewController!
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!
    var allowPan = true
    
    var originCenter: CGPoint!
    let width: CGFloat = 150.0
    let height: CGFloat = 170.0
    
    //MARK: Initialization
    init(image: UIImage, moduleKey: TypeKeys, originCenter: CGPoint, viewController: ViewController) {
        super.init(image: image)
        let x = originCenter.x - (width / 2)
        let y = originCenter.y - (height / 2)
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.moduleKey = moduleKey
        self.viewController = viewController
        self.originCenter = originCenter
//        setupMargins()
        setupGestures()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        originCenter = self.center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        originCenter = self.center
    }
    
    func setupMargins() {
        let margins = self.layoutMarginsGuide
        viewController.view.trailingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
    }
    
    func setupModuleInfo(image: UIImage?, moduleKey: TypeKeys, viewController: ViewController) {
        self.image = image
        self.moduleKey = moduleKey
        self.viewController = viewController
        setupGestures()
    }
    
    //MARK: Private Methods
    private func setupGestures() {
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
                // Check if ModuleImageView is intersecting with another ModuleImageView
                for imageView in viewController.imageViews {
                    let intersecting = (imageView != self && gesture.view!.frame.intersects(imageView.frame))
                    self.layer.borderColor = intersecting ? UIColor.red.cgColor : UIColor.lightGray.cgColor
                    self.layer.borderWidth = 1.0
                    if (intersecting) {break}
                }
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
                    self.layer.borderColor = nil
                }
            default:
                print("NO PAN GESTURE STATES MATCHED")
        }
    }
    
    @objc func tapGesture(gesture: ModuleTap) {
        gesture.moduleType = self.moduleKey
        viewController.callSegue(sender: gesture)
    }
}
