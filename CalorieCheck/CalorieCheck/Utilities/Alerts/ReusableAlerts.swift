//
//  ReusableAlerts.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/10/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class ResusableAlerts {
    
    static func areYouCheatingAlert(vc: UIViewController) {
        let alertController = UIAlertController(title: "Are you Cheating?", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            // present apple purchase asking for a 1$ donation
        }
        
        let no = UIAlertAction(title: "No", style: .default) { (_) in
            // continue with the flow
        }
        
        alertController.addAction(cancel)
        alertController.addAction(yes)
        alertController.addAction(no)
        vc.present(alertController, animated: true)
    }
}
