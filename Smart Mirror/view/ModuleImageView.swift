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
    public var module: Module!
    var viewController: ViewController!
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!
    var allowPan = true
    public var onMirror = true
    
    var originCenter: CGPoint!
    let width: CGFloat = 150.0
    let height: CGFloat = 170.0
    
    //MARK: Initialization
    init(image: UIImage, module: Module, /*originCenter: CGPoint,*/ viewController: ViewController) {
        super.init(image: image)
        self.module = module
        self.viewController = viewController
//        self.originCenter = originCenter
        initOriginCenter()
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
    
    func initOriginCenter() {
        switch module.position {
            case PositionStr.TOPLEFT.rawValue:
                originCenter = Positions.TOPLEFT_CENTER
            case PositionStr.TOPRIGHT.rawValue:
                originCenter = Positions.TOPRIGHT_CENTER
            case PositionStr.BOTTOMLEFT.rawValue:
                originCenter = Positions.BOTTOMLEFT_CENTER
            case PositionStr.BOTTOMRIGHT.rawValue:
                originCenter = Positions.BOTTOMRIGHT_CENTER
            case PositionStr.NONE.rawValue:
                print("\(module.name) is not on mirror")
                onMirror = false
            default:
                print("\(module.name) UNKNOWN POSITION")
        }
        if (onMirror) {
            let x = originCenter.x - (width / 2)
            let y = originCenter.y - (height / 2)
            self.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func setupMargins() {
        let margins = self.layoutMarginsGuide
        viewController.view.trailingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
    }
    
    func setupModuleInfo(image: UIImage?, module: Module, viewController: ViewController) {
        self.image = image
        self.module = module
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
    
    private func checkArea(_ me: UIView) -> (goodSpace: Bool, intersecting: Bool, newSpace: CGRect) {
        var goodSpace = false
        var intersecting = false
        var newSpace = CGRect()
        // Go through all good spaces
        for space in viewController.goodSpaces {
            // Check if in good space
            goodSpace = (me.center.x >= space.minX && me.center.x <= space.maxX &&
                me.center.y >= space.minY && me.center.y <= space.maxY)
            let spaceCenter = CGPoint(x: space.midX, y: space.midY)
            if (goodSpace && spaceCenter == originCenter) {
                goodSpace = false
                intersecting = false
                break
            }
            // Check if it is intersecting with another view
            for imageView in viewController.imageViews {
                intersecting = imageView != self && imageView.onMirror && me.frame.intersects(imageView.frame)
                if (intersecting) {break}
            }
            // Set new good space
            if (goodSpace) {
                newSpace = space
            }
            if (intersecting || goodSpace) {break}
        }
        return (goodSpace, intersecting, newSpace)
    }
    
    private func setNewPosition() {
        if (originCenter == Positions.TOPLEFT_CENTER) {
            module.position = PositionStr.TOPLEFT.rawValue
        }
        else if (originCenter == Positions.TOPRIGHT_CENTER) {
            module.position = PositionStr.TOPRIGHT.rawValue
        }
        else if (originCenter == Positions.BOTTOMLEFT_CENTER) {
            module.position = PositionStr.BOTTOMLEFT.rawValue
        }
        else if (originCenter == Positions.BOTTOMRIGHT_CENTER) {
            module.position = PositionStr.BOTTOMRIGHT.rawValue
        }
        
        // Send POST request to web server 
        APIControl.moduleUpdate(module)
    }
    
    //MARK: Actions
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        if !allowPan {return}
        switch gesture.state {
            case .began, .changed:
                // Check if this view is currently in a good space
                var borderColor = UIColor.gray.cgColor
                let spaceCheck = checkArea(gesture.view!)
                if (spaceCheck.goodSpace && !spaceCheck.intersecting) {
                    borderColor = UIColor.green.cgColor
                }
                else if (spaceCheck.intersecting) {
                    borderColor = UIColor.red.cgColor
                }
                self.layer.borderColor = borderColor
                self.layer.borderWidth = 1.0
                
                // Move the view with the pan
                let translation = gesture.translation(in: self)
                gesture.view!.center = CGPoint(
                    x: gesture.view!.center.x + translation.x,
                    y: gesture.view!.center.y + translation.y
                )
                gesture.setTranslation(CGPoint(x: 0, y: 0), in: self)
            case .ended:
                // Check if this view can be moved to a new space
                let spaceCheck = checkArea(gesture.view!)
                if (spaceCheck.goodSpace && !spaceCheck.intersecting) {
                    originCenter = CGPoint(x: spaceCheck.newSpace.midX, y: spaceCheck.newSpace.midY)
                    setNewPosition()
                }
                // If not in original center, snap back
                if gesture.view!.center != originCenter {
                    snapBackToOrigin()
                    self.layer.borderColor = nil
                    self.layer.borderWidth = 0.0
                }
            default:
                print("NO PAN GESTURE STATES MATCHED")
        }
    }
    
    @objc func tapGesture(gesture: ModuleTap) {
        gesture.module = self.module
        viewController.callSegue(sender: gesture)
    }
}
