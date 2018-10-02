//
//  AccountVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 02/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableViewVC: UITableView!
    
    let imagesIcon = ["accountVehicles", "accountCard", "accountCart", "accountSettings", "accountHelp", "accountInvite", "accountAbout", "accountTerms", "accountLogOut"]
    let labelTexts = ["My Vehicles", "Saved cards", "My Cart", "Settings", "24x7 Help", "Invite", "About us", "Terms of service", "LogOut"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewVC.delegate = self
        tableViewVC.dataSource = self
      
       
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

   
}
