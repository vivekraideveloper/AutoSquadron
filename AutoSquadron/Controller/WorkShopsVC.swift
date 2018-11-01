//
//  WorkShopsVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 01/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class WorkShopsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workshopTableView: UITableView!

    var workshopData = [WorkshopModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workshopTableView.delegate = self
        workshopTableView.dataSource = self
        workshopTableView.separatorStyle = .singleLine
        workshopTableView.separatorColor = UIColor.black
        loadWorkshops()
    }
    
    
    func loadWorkshops() {
            Database.database().reference().child("workshops").observe(.childAdded, with: { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    let name = dict["name"] as! String
                    let imageUrl = dict["imageUrl"] as! String
                    let img1 = dict["img1"] as! String
                    let img2 = dict["img2"] as! String
                    let img3 = dict["img3"] as! String
                    let shortDesc = dict["shortDesc"] as! String
                    let services = dict["services"] as! Dictionary<String, String>
                    let data = WorkshopModel(name: name, imageUrl: imageUrl, img1: img1, img2: img2, img3: img3, shortDesc: shortDesc, services: services)
                    self.workshopData.append(data)
                    self.workshopTableView.reloadData()
                }
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshopData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workshopTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkShopCell
        
        let data = workshopData[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: data.imageUrl))
        cell.workshopName.text = data.name
        cell.workshopDesc.text = data.shortDesc
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workshop", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WorkshopDetailVC
        destinationVC._workshopName = workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].name
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img1)
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img2)
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img3)
        
        for (key, value) in workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].services{
            destinationVC.serviceNameArray.append(key)
            destinationVC.servicePriceArray.append(value)
        }
            
    }
    
}
