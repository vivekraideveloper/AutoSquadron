//
//  CheckOutVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 08/01/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit

class CheckOutVC: UIViewController {

    @IBOutlet weak var serviceStationNameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var couponCodeTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    var discountedPriceText: String?
    var serviceStationNameText: String?
    var dateAndTimeText: String?
    var vehicleNameText: String?
    var addressText: String?
    var couponCodeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myVehicle = MyVehicle()
        vehicleNameLabel.text = myVehicle.defaults.string(forKey: "vehicleName") ?? "No Vehcicle"
        let myAddress = MyAddress()
        addressLabel.text = myAddress.defaults.string(forKey: "address") ?? "No Address"
        serviceStationNameLabel.text = serviceStationNameText
        dateAndTimeLabel.text = dateAndTimeText
        priceLabel.text = discountedPriceText

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let myVehicle = MyVehicle()
        vehicleNameLabel.text = myVehicle.defaults.string(forKey: "vehicleName") ?? "No Vehcicle"
        let myAddress = MyAddress()
        addressLabel.text = myAddress.defaults.string(forKey: "address") ?? "No Address"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editVehicleButton(_ sender: Any) {
        
        let myVehicle = MyVehicle()

        
        let alertVC = UIAlertController(title: "Your selected vehicle is ", message: myVehicle.defaults.string(forKey: "vehicleName") ?? "No Vehcicle", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Edit", style: .default) { action in
            self.performSegue(withIdentifier: "editVehicle", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func editAddressButton(_ sender: Any) {
        let alertVC = UIAlertController(title: "Enter your Addess", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            
            if let textField = alertVC.textFields?.first,
                let address = textField.text {
                
                let myAddress = MyAddress()
                myAddress.defaults.setValue(address, forKey: "address")
                
                self.addressLabel.text = address
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        
    }
    
}
