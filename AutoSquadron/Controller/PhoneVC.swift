//
//  PhoneVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 06/02/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD

class PhoneVC: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.layer.cornerRadius = 20

    }
    
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        
        guard let phoneNumber = phoneTextField.text else {return}
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verficationId, error) in
            if error == nil{
                
                let otpVerfication = OTPVerfication()
                guard let verifyId = verficationId else {return}
                otpVerfication.defaults.set(verifyId, forKey: "verifyId")
                otpVerfication.defaults.synchronize()
                
                let alertVC = UIAlertController(title: "Enter OTP", message: nil, preferredStyle: .alert)
                
                alertVC.addTextField { textField in
                    if #available(iOS 12.0, *) {
                        textField.textContentType = UITextContentType.oneTimeCode
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                let okAction = UIAlertAction(title: "Ok", style: .default) { action in
                    
                    SVProgressHUD.show()
                    
                    if let textField = alertVC.textFields?.first,
                        let otp = textField.text {
                        let otpVerificationId = OTPVerfication()
                        
                        let credential = PhoneAuthProvider.provider().credential(withVerificationID: otpVerificationId.defaults.string(forKey: "verifyId")!, verificationCode: otp)
                       
//                        Auth.auth().signInAndRetrieveData(with: credential, completion: { (success, error) in
//                            if error == nil{
                        
                        
                        
                                SVProgressHUD.dismiss()
                                print("################# Signed In Successfully")
                                
//                                Add phone to Database
                                guard let uid = Auth.auth().currentUser?.uid else { return }
                                
                                
                                let dictionaryValues = ["phone": phoneNumber]
                                
                                let values = [uid: dictionaryValues]
                                print("&&&&&&&&&&&&&&&&&&&&&&&&", uid)

                                Database.database().reference().child("users").child(uid).child("phone").setValue(phoneNumber)
                                
                                
//                                Perform Action
                                
                                let alert = UIAlertController(title: "Your number is verified successfully", message: nil, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                                    SVProgressHUD.dismiss()
                                    self.dismiss(animated: true, completion: nil)
                                })
                                
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                SVProgressHUD.dismiss()
                                print("Error ocurred ",error?.localizedDescription as Any)
                                let alert = UIAlertController(title: "Wrong OTP Entered", message: nil, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "Verify Again", style: .cancel, handler: { (action) in
                                    SVProgressHUD.dismiss()
                                })
                                
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                            }
//                        })
                    
//                    }else{
//                        return
//                    }
                
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                    
                }
                
                alertVC.addAction(okAction)
                alertVC.addAction(cancelAction)
                
                self.present(alertVC, animated: true, completion: nil)
                
            }else{
                print("*******************************Error occured", error?.localizedDescription as Any)
            }
        }
        
       

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
