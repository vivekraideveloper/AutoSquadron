//
//  SelectVehicleVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 03/11/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase

class SelectVehicleVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var vehicleSearchBar: UISearchBar!
    @IBOutlet weak var vehicleTableView: UITableView!
    
    var inSearchMode = false
    var vehicleArray = [SelectVehicleModel]()
    var filteredVehicleArray = [SelectVehicleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vehicleTableView.delegate = self
        vehicleTableView.dataSource = self
        vehicleSearchBar.delegate = self
        
        vehicleSearchBar.returnKeyType = UIReturnKeyType.done
        
        loadVehicles()
        
    }
    
    func loadVehicles() {
        Database.database().reference().child("vehicles").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.key as? String {
                let data = SelectVehicleModel(name: dict)
                self.vehicleArray.append(data)
                self.vehicleTableView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredVehicleArray.count
        }
        return vehicleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SelectVehicleCell{
            if inSearchMode{
                cell.vehicleName.text = filteredVehicleArray[indexPath.row].name
            }else{
                cell.vehicleName.text = vehicleArray[indexPath.row].name
            }
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            vehicleTableView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            let text = searchBar.text!
            filteredVehicleArray = vehicleArray.filter({$0.name.range(of: text) != nil})
            vehicleTableView.reloadData()
            
        }
    }
    
}
