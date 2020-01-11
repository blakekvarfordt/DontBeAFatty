//
//  Animations.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class Animations {
    
    static func transitionUpwards(view: UIView, height: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            var animatingView = view.frame
          animatingView.origin.y -= height
          view.frame = animatingView
            
        }, completion: { finished in
          print("Napkins opened!")
        })
    }
    
    static func transitionDownwards(view: UIView, height: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            var animatingView = view.frame
          animatingView.origin.y += height
          view.frame = animatingView
            
        }, completion: { finished in
          print("Napkins opened!")
        })
    }

}

