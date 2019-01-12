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
import SVProgressHUD

class WorkShopsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workshopTableView: UITableView!

    var workshopData = [WorkshopModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
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
        let cell = workshopTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkShopCell
        
        let data = workshopData[indexPath.row]
        //cell.imageView?.sd_setShowActivityIndicatorView(true)
        
       // cell.imageView?.sd_setIndicatorStyle(.white)
         cell.imageView?.sd_setImage(with: URL(string: data.imageUrl), placeholderImage: UIImage(named: "placeholder"))
        { (image:UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

            //new size
            cell.imageView?.image = self.resizeImage(image: image!, newWidth: 150)
        }
//         cell.imageView?.sd_setImage(with: URL(string: data.imageUrl))
        cell.workshopName.text = data.name
        cell.workshopDesc.text = data.shortDesc
        SVProgressHUD.dismiss()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workshop", sender: self)
        
        self.workshopTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WorkshopDetailVC
        destinationVC._workshopName = workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].name
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img1)
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img2)
        destinationVC.images.append(workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].img3)
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
//        for (key, value) in workshopData[(workshopTableView.indexPathForSelectedRow?.row)!].services{
//            destinationVC.serviceNameArray.append(key)
//            destinationVC.servicePriceArray.append(value)
//        }
        
    }
        func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
            
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: 100))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: 100))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
        }
}
