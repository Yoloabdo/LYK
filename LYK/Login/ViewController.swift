//
//  ViewController.swift
//  LYK
//
//  Created by abdelrahman mohamed on 12/2/17.
//  Copyright © 2017 abdelrahman mohamed. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LoginViewController: UIViewController {

    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        guard (result) != nil else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}
