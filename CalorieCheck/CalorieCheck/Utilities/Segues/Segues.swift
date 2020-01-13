//
//  Segues.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class Segues {
    
    static func presentViewController(vc: UIViewController, name: String, id: String) {
        let storyboard = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id)
        storyboard.modalPresentationStyle = .overFullScreen
        storyboard.modalTransitionStyle = .crossDissolve
        vc.present(storyboard, animated: true)
    }
}

