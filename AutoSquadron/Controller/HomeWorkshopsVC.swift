//
//  HomeWorkshopsVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 28/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase

class HomeWorkshopsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var workshopTableView: UITableView!
    var databaseReference: DatabaseReference!
    var workshopData = [WorkshopsLayout]()
    var serviceType: String = ""
    
    @IBOutlet weak var serviceTypeName: UILabel!
    
//    var images = ["1","2","3","1","2","3"]
//    var workshopNames = ["Zyro Cars", "GoBumper", "Energic Car Wash", "Zyro Cars", "GoBumper", "Energic Car Wash"]
//    var workshopDescription = ["Sample deal for paints", "Sample deal for repair", "Sample deal for wash", "Sample deal for paints", "Sample deal                 for repair", "Sample deal for wash"]
    
    var images = [String]()
    var workshopNames = [String]()
    var workshopDescription = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workshopTableView.delegate = self
        workshopTableView.dataSource = self
        serviceTypeName.text = serviceType

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = workshopTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeWorkshpCell
        cell.workshopImageView?.sd_setImage(with: URL(string: images[indexPath.row]))
//        cell.workshopImageView.image = UIImage(named: images[indexPath.row])
        cell.name.text = workshopNames[indexPath.row]
        cell.shortDesc.text = workshopDescription[indexPath.row]
        return cell
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
