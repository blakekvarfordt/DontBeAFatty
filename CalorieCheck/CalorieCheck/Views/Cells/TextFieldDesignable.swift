//
//  CustomTextField.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldDesignable: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .green {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
}
