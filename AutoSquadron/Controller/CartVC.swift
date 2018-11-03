//
//  CartVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 02/11/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

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
        
//        let swipeCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SwipeTableViewCell
//        swipeCell.delegate = self
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkOutButtonPressed(_ sender: Any) {
//        Perform Payment gateway
    }
}
