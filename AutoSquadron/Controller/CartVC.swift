//
//  CartVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 02/11/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import RealmSwift

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    let realm = try! Realm()
    var data: Results<CartData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        loadData()
    }
    
    func loadData() {
        data = realm.objects(CartData.self)
        self.cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        cell.serviceTypeName.text = data[indexPath.row].serviceName
        cell.servicePrice.text = "Rs \(data[indexPath.row].servicePrice)"
        cell.workshopName.text = data[indexPath.row].workshopName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        do{
            try realm.write {
                realm.delete(item)
                self.cartTableView.reloadData()
            }
        }catch{
            print("Error while deleting")
        }
        self.cartTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkOutButtonPressed(_ sender: Any) {
//        Perform Payment gateway
    }
}
