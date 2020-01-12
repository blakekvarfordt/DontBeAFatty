//
//  CustomButton.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var color: UIColor = .green {
           didSet {
               self.setTitleColor(color, for: .normal)
               layer.borderColor = color.cgColor
           }
       }
    
    @IBInspectable var width: CGFloat {
        self.frame.width
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
