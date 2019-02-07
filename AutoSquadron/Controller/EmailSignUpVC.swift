//
//  EmailSignUpVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 04/02/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class EmailSignUpVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeViews()

        
    }
    func customizeViews() {
        logoImageView.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
        nameTextField.layer.cornerRadius = 5
        emailTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if emailTextField.hasText && passwordTextField.hasText && nameTextField.hasText{
            
            SVProgressHUD.show()
            
            // properties
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            guard let fullName = nameTextField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                
                // handle error
                if let error = error {
                    SVProgressHUD.dismiss()
                    print("DEBUG: Failed to create user with error: ", error.localizedDescription)
                    return
                }
                
                guard let uid = authResult?.user.uid else { return }
               
                
                let dictionaryValues = ["name": fullName,
                                        "email": email,
                                        "phone": "",
                                        "password": password]
                
                let values = [uid: dictionaryValues]
                
                // save user info to database
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                    self.performSegue(withIdentifier: "signIn", sender: self)
                   
                    SVProgressHUD.dismiss()
                    
                })
                
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func alreadyAccountButton(_ sender: Any) {
//        performSegue(withIdentifier: "alreadyAccount", sender: self)
         dismiss(animated: true, completion: nil)
    }
    
}
