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
import RealmSwift

class AccountVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var tableViewVC: UITableView!
    
    let loginManager = FBSDKLoginManager()
    let imagesIcon = ["phone", "email2", "accountVehicles", "accountCard", "accountCart", "accountShare", "accountAbout", "accountTerms", "accountLogOut"]
    let labelTexts = ["Mobile Number", "E-mail", "My Vehicles", "My Address", "My Cart", "Share", "About us", "Terms of service", "LogOut"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewVC.delegate = self
        tableViewVC.dataSource = self
        tableViewVC.allowsSelection = true
        userDetail()
       
    }
    
    func userDetail(){
        guard let name = Auth.auth().currentUser?.displayName else {return}
        nameLabel.text = name
        
        guard let email = Auth.auth().currentUser?.email else {
            emailLabel.text = "No Email setup"
            return
            
        }
        emailLabel.text = email
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
        
        if labelTexts[indexPath.row] == "Mobile Number"{
            performSegue(withIdentifier: "phoneAuth", sender: self)
        }
        
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
        
        if labelTexts[indexPath.row] == "My Cart"{
            performSegue(withIdentifier: "MyCart", sender: self)
        }
        
        if labelTexts[indexPath.row] == "My Vehicles"{
            let myVehicle = MyVehicle()
            
            let alertVC = UIAlertController(title: "Your selected vehicle is ", message: myVehicle.defaults.string(forKey: "vehicleName") ?? "No Vehicle", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Edit", style: .default) { action in
                        
                        self.performSegue(withIdentifier: "MyVehicle", sender: self)
            
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                    }
            
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                    self.tableViewVC.deselectRow(at: indexPath, animated: true)
        }
        
        
        if labelTexts[indexPath.row] == "My Address"{
            let alertVC = UIAlertController(title: "Enter your Addess", message: nil, preferredStyle: .alert)
            
            alertVC.addTextField { textField in
                
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { action in
                
                if let textField = alertVC.textFields?.first,
                    let address = textField.text {
                    
                        let myAddress = MyAddress()
                        myAddress.defaults.setValue(address, forKey: "address")
                                        
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                
            }
            
            alertVC.addAction(okAction)
            alertVC.addAction(cancelAction)
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
