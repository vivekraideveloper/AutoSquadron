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
import Kingfisher

class WorkShopsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workshopTableView: UITableView!
    
    var databaseReference: DatabaseReference!
    var workshopData = [WorkshopsLayout]()
    
    let images = ["1","2","3", "1","2","3"]
    
    let workshopNames = ["Zyro Cars", "GoBumper", "Energic Car Wash", "Zyro Cars", "GoBumper", "Energic Car Wash"]
    let workshopDescription = ["Sample deal for paints", "Sample deal for repair", "Sample deal for wash", "Sample deal for paints", "Sample deal for repair", "Sample deal for wash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workshopTableView.delegate = self
        workshopTableView.dataSource = self
        
        workshopTableView.separatorStyle = .singleLine
        workshopTableView.separatorColor = UIColor.black
        
        databaseReference = Database.database().reference().child("workshops")
        
        loadWorkshops()

    }
    
    func loadWorkshops() {
        databaseReference.observe(DataEventType.value, with: { (snapshot) in
            
            var newData = [WorkshopsLayout]()
            
            for dataSnapshot in snapshot.children{
                let dataObject = WorkshopsLayout(snapshot: dataSnapshot as! DataSnapshot)
                newData.append(dataObject)
                
            }
            self.workshopData = newData
            self.workshopTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return images.count
        return workshopData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workshopTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkShopCell
        
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.workshopName.text = workshopNames[indexPath.row]
        cell.workshopDesc.text = workshopDescription[indexPath.row]
        
        let data = workshopData[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: data.imageUrl))
        
        cell.imageView?.contentMode = .scaleAspectFit
//      cell.imageView?.kf.setImage(with: data.imageUrl as! Resource)
        
//        var serviceData = workshopData[indexPath.row].services
//        print(ser)
        
        
        cell.workshopName.text = data.name
        cell.workshopDesc.text = data.shortDesc
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workshop", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "workshop"{
            let destinationVC = segue.destination as! WorkshopDetailVC
            destinationVC._workshopName = workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].name
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img1)
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img2)
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img3)
            
            for (key, value) in workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].services{
                destinationVC.serviceNameArray.append(key)
                print(key)
                destinationVC.servicePriceArray.append(value)
                print(value)
            }
            
        }
    }
    
   

}
