//
//  Segues.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class Segues {
    static func presentSetLimitPopup(vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "SetLimit")
        storyboard.modalPresentationStyle = .overFullScreen
        storyboard.modalTransitionStyle = .crossDissolve
        vc.present(storyboard, animated: true)
    }
    
    static func presentLogin(vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        storyboard.modalPresentationStyle = .overFullScreen
        storyboard.modalTransitionStyle = .crossDissolve
        vc.present(storyboard, animated: true, completion: nil)
    }
}
