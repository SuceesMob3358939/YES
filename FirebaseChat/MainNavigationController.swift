//
//  MainNavigationController.swift
//  FirebaseChat
//
//  Created by GOOD on 12/21/16.
//  Copyright © 2016 mrGott. All rights reserved.
//

import UIKit
import Firebase

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // setViewControllers(viewControllersList, animated: true)
        if FIRAuth.auth()?.currentUser == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0.1)
        }
        
        let homeController = HomeController()
        viewControllers = [homeController]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLogout(){
        let loginController = LoginViewController()
        present(loginController, animated: true) { 
            //maybe someday
        }
    }

}
