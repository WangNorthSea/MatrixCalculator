//
//  PopAnimator.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/25.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import AudioToolbox

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    let duration = 0.6
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let calculateView = presenting ? toView : transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : calculateView.frame
        let finalFrame = presenting ? calculateView.frame : originFrame
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            calculateView.transform = scaleTransform
            calculateView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            calculateView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront:calculateView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
            calculateView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            calculateView.center = CGPoint(x:finalFrame.midX, y:finalFrame.midY)
            if self.presenting {
                AudioServicesPlaySystemSound(1519)
            }
        }, completion: {_ in
            transitionContext.completeTransition(true)})
    }
}
