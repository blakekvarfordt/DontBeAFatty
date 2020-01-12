//
//  ViewDesignable.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

@IBDesignable
class ViewDesignable: UIView {
    
    @IBInspectable var color: UIColor = .green {
        didSet {
            layer.borderColor = color.cgColor
            backgroundColor = color
            alpha = 0.6
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
