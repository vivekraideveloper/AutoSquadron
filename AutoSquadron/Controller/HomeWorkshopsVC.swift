//
//  HomeWorkshopsVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 28/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeWorkshopsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workshopTableView: UITableView!
    @IBOutlet weak var serviceTypeName: UILabel!
    
    var databaseReference: DatabaseReference!
    var workshopData = [WorkshopModel]()
    var reference: String!
    var serviceName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workshopTableView.delegate = self
        workshopTableView.dataSource = self
        workshopTableView.separatorStyle = .singleLine
        workshopTableView.separatorColor = UIColor.black
        databaseReference = Database.database().reference().child(reference)
        loadWorkshops()
        serviceTypeName.text = serviceName
    }
    
    
    func loadWorkshops() {
        databaseReference.observe(DataEventType.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let name = dict["name"] as! String
                let imageUrl = dict["imageUrl"] as! String
                let img1 = dict["img1"] as! String
                let img2 = dict["img2"] as! String
                let img3 = dict["img3"] as! String
                let shortDesc = dict["shortDesc"] as! String
                let services = dict["services"] as! Dictionary<String, Dictionary<String, Any>>
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
        let cell = workshopTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeWorkshpCell
        
        let data = workshopData[indexPath.row]
//        cell.imageView?.sd_setImage(with: URL(string: data.imageUrl), placeholderImage: UIImage(named: "placeholder"))
        cell.imageView?.sd_setImage(with: URL(string: data.imageUrl), placeholderImage: UIImage(named: "placeholder"))
        { (image:UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in
            
            //new size
            cell.imageView?.image = self.resizeImage(image: image!, newWidth: 150)
        }
        cell.name.text = data.name
        cell.shortDesc.text = data.shortDesc
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "service", sender: self)
        self.workshopTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "service"{
            let destinationVC = segue.destination as! WorkshopDetailVC
            destinationVC._workshopName = workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].name
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img1)
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img2)
            destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img3)
//            for (key, value) in workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].services{
//                destinationVC.serviceNameArray.append(key)
//                destinationVC.servicePriceArray.append(value)
//            }
            for (key, value) in workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].services{
                destinationVC.serviceNameArray.append(key)
                for (iKey, iValue) in value{
                    print(iKey)
                    print(iValue)
                    if iKey == "price"{
                        destinationVC.servicePriceArray.append(iValue as! String)
                        
                    }
                    
                    if iKey == "details"{
                        destinationVC.serviceDetailArray.append(iValue as! String)
                    }
                    
                    
                }
            }

            
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
//        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: 100))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: 100))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
