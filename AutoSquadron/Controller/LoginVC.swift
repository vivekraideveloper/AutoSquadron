//
//  LoginVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 04/11/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    let loginManager = FBSDKLoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (Auth, user) in
            if user != nil{
                self.performSegue(withIdentifier: "socialLogin", sender: self)
                print("User logged in!")
            }
        }
    }
    
//    Google SignIn

    @IBAction func googleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
//    Facebook SignIn
    
    @IBAction func facebookSignInButton(_ sender: Any) {
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if let error  = error{
                debugPrint("Error ocurred while Login: \(error)")
            }else if (result?.isCancelled)!{
                print("FB Login was cancelled")
            }else{
                let credential = FacebookAuthProvider.credential(withAccessToken: (FBSDKAccessToken.current()?.tokenString)!)
                self.firebaseLogin(credential)
            }
            
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let error = error{
            debugPrint("Error while login \(error)")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
        firebaseLogin(credential)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
//    Firebase
    
    func firebaseLogin(_ credential: AuthCredential){
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            if let error = error {
                print("Error occured \(error.localizedDescription)")
                return
            }
        }
    }
    
}
