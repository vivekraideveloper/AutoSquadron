//
//  AccountVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 02/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SVProgressHUD
import FBSDKLoginKit

class AccountVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableViewVC: UITableView!
    
    let loginManager = FBSDKLoginManager()
    let imagesIcon = ["accountVehicles", "accountCard", "accountCart", "accountSettings", "accountHelp", "accountInvite", "accountAbout", "accountTerms", "accountLogOut"]
    let labelTexts = ["My Vehicles", "Saved cards", "My Cart", "Settings", "24x7 Help", "Invite", "About us", "Terms of service", "LogOut"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewVC.delegate = self
        tableViewVC.dataSource = self
        tableViewVC.allowsSelection = true
      
       
    }
    
    func socialLogout(){
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        for info in (user.providerData){
            switch info.providerID{
            case GoogleAuthProviderID:
                GIDSignIn.sharedInstance()?.signOut()
                print("google")
            case FacebookAuthProviderID:
                loginManager.logOut()
                print("Facebook")
            case TwitterAuthProviderID:
                print("Twitter")
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesIcon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountCellVC
        cell.accountImageIcons.image = UIImage(named: imagesIcon[indexPath.row])
        cell.labelText.text = labelTexts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableViewVC.deselectRow(at: indexPath, animated: true)
        
        if labelTexts[indexPath.row] == "LogOut"{
            let logoutPopUp = UIAlertController(title: "Logout", message: "Do you want to logout?", preferredStyle: .actionSheet)
            let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
                SVProgressHUD.show()
                
                do {
                    self.socialLogout()
                    try Auth.auth().signOut()
                    print("SignOut Pressed")
                    SVProgressHUD.dismiss(withDelay: 3, completion: {
                        self.performSegue(withIdentifier: "logout", sender: self)
                    })
                    
                } catch let err {
                    print(err)
                    SVProgressHUD.dismiss()
                }
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            }
            
            logoutPopUp.addAction(logoutAction)
            logoutPopUp.addAction(cancelAction)
            present(logoutPopUp, animated: true, completion: nil)
            
        }
    }
    

   
}
