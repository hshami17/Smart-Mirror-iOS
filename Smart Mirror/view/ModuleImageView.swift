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
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    }
    
    //MARK: Actions
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.began || gesture.state == UIGestureRecognizerState.changed {
            let translation = gesture.translation(in: self)
//            print(gestureRecognizer.view!.center.y)
            
//            var y: CGFloat
//            if(gestureRecognizer.view!.center.y < 555) {
//                y = gestureRecognizer.view!.center.y + translation.y
//            }
//            else {
//                y = 554
//            }
            
            gesture.view!.center = CGPoint(
                x: gesture.view!.center.x + translation.x,
                y: gesture.view!.center.y + translation.y
            )
            gesture.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
    }
}
