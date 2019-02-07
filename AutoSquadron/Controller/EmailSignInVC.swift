//
//  EmailSignInVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 04/02/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class EmailSignInVC: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeViews()
        
    }
    
    func customizeViews() {
        logoImageView.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        emailTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.hasText && passwordTextField.hasText{
            SVProgressHUD.show()
            
            // properties
            guard
                let email = emailTextField.text,
                let password = passwordTextField.text else { return }
            
            // sign user in with email and password
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                // handle error
                if let error = error {
                    SVProgressHUD.dismiss()
                    print("Unable to sign user in with error", error.localizedDescription)
                    return
                }
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "signIn", sender: self)
            }
        }
    }
    
    @IBAction func dontHaveAccountButtonPressed(_ sender: Any) {
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
