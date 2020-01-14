//
//  LoadingViewController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/12/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateListener()
    }
    
    func stateListener() {
        FirebaseManager.addStateListener(vc: self) { (success) in
            if success {
                Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.input)
            } else {
                Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.login)
            }
        }
    }
    
    func fetchUser() {
        guard let user = FirebaseManager.currentUser else { return }
        UserController.shared.fetchUser(uid: user) { (user) in
            if user != nil {
                // run some logic. IDK
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
