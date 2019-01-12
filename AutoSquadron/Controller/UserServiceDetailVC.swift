//
//  UserServiceDetailVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 07/01/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit

class UserServiceDetailVC: UIViewController {
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pickUpAndDropSwitch: UISwitch!
    @IBOutlet weak var serviceDetailsLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var serviceNameText: String?
    var serviceStationNameText: String?
    var servicePriceText: String?
    var serviceDetailText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceNameText
        priceLabel.text = servicePriceText
        serviceDetailsLabel.text = serviceDetailText
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//         print("Heloo+++++++++++++++++++++++++++")
    }
    
    @IBAction func proceedToCheckoutButton(_ sender: Any) {
        performSegue(withIdentifier: "checkout", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkout"{
            let destinationVC = segue.destination as! CheckOutVC
            destinationVC.discountedPriceText = servicePriceText
            var dateText = datePicker.date.description
            destinationVC.dateAndTimeText = dateText
            destinationVC.serviceStationNameText = serviceStationNameText
            
        }
    }
    
}
