//
//  FirstViewController.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 16/09/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage
import SVProgressHUD

class HomeVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var generalServiceCollectionView: UICollectionView!
    @IBOutlet weak var bodyPaintingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var homeServiceItemArray = [WorkshopsLayout]()
    var customLayout: CustomImageFlowLayout!
    var collectionImages = [HomeOfferLayout]()
    
    var generalServiceDatabaseReference: DatabaseReference!
    var bodyPaintingDatabaseReference: DatabaseReference!
    
//    Arrays
    var genralWorkshopArray = [WorkshopModel]()
    var bodyPaintingWorkshopArray = [WorkshopModel]()
    
//    Variables used to perfrom segue
    var name: String!
    var img1: String!
    var img2: String!
    var img3: String!
    var serviceName = [String]()
    var servicePrice = [String]()
    
    
    var images = ["placeholder", "placeholder","placeholder"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        generalServiceDatabaseReference = Database.database().reference().child("genralServiceWorkshops")
        bodyPaintingDatabaseReference = Database.database().reference().child("bodyPaintingServiceWorkshops")
        
        loadGeneralWorkshops()
        loadBodyPaintingWorkshops()
       
        pageControlSwipe()
        
        customLayout = CustomImageFlowLayout()
        
        
        
    }
    
    func loadGeneralWorkshops() {
        generalServiceDatabaseReference.observe(DataEventType.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let name = dict["name"] as! String
                let imageUrl = dict["imageUrl"] as! String
                let img1 = dict["img1"] as! String
                let img2 = dict["img2"] as! String
                let img3 = dict["img3"] as! String
                let shortDesc = dict["shortDesc"] as! String
                let services = dict["services"] as! Dictionary<String, Dictionary<String, Any>>
                let data = WorkshopModel(name: name, imageUrl: imageUrl, img1: img1, img2: img2, img3: img3, shortDesc: shortDesc, services: services)
                self.genralWorkshopArray.append(data)
                self.generalServiceCollectionView.delegate = self
                self.generalServiceCollectionView.dataSource = self
                self.generalServiceCollectionView.reloadData()
                
            }
        })
    }
    
    func loadBodyPaintingWorkshops() {
        bodyPaintingDatabaseReference.observe(DataEventType.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let name = dict["name"] as! String
                let imageUrl = dict["imageUrl"] as! String
                let img1 = dict["img1"] as! String
                let img2 = dict["img2"] as! String
                let img3 = dict["img3"] as! String
                let shortDesc = dict["shortDesc"] as! String
                let services = dict["services"] as! Dictionary<String, Dictionary<String, Any>>
                let data = WorkshopModel(name: name, imageUrl: imageUrl, img1: img1, img2: img2, img3: img3, shortDesc: shortDesc, services: services)
                self.bodyPaintingWorkshopArray.append(data)
                self.bodyPaintingCollectionView.delegate = self
                self.bodyPaintingCollectionView.dataSource = self
                self.bodyPaintingCollectionView.reloadData()
                
            }
        })
    }
    
    
    func pageControlSwipe() {
        scrollView.layer.cornerRadius = 10
        pageControl.numberOfPages = images.count
        
        for index in 0..<images.count{
            
            frame.origin.x = scrollView.frame.size.width*CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imageView)
            
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width*CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @IBAction func generalServiceButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "generalService", sender: self)
    }
    
    @IBAction func bodyPaintingButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "bodyPainitngService", sender: self)
    }
    
    @IBAction func cartButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "cart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "generalService"{
            let destinationVC = segue.destination as! HomeWorkshopsVC
            destinationVC.reference = "genralServiceWorkshops"
            destinationVC.serviceName = "General Service"
        }
        
        if segue.identifier == "bodyPainitngService"{
            let destinationVC = segue.destination as! HomeWorkshopsVC
            destinationVC.reference = "bodyPaintingServiceWorkshops"
            destinationVC.serviceName = "Body Painting"
        }
        
        
        if segue.identifier == "collectionGeneralService"{
            let destinationVC = segue.destination as! WorkshopDetailVC
            destinationVC._workshopName = self.name
            destinationVC.images.append(img1)
            destinationVC.images.append(img2)
            destinationVC.images.append(img3)
            
            let iPath = self.generalServiceCollectionView.indexPathsForSelectedItems
            let indexPath : NSIndexPath = iPath![0] as NSIndexPath
            let rowIndex = indexPath.row
            
            for (key, value) in genralWorkshopArray[(rowIndex)].services{
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

        if segue.identifier == "collectionBodyPainitngService"{
            let destinationVC = segue.destination as! WorkshopDetailVC
            destinationVC._workshopName = self.name
            destinationVC.images.append(img1)
            destinationVC.images.append(img2)
            destinationVC.images.append(img3)
            
            let iPath = self.bodyPaintingCollectionView.indexPathsForSelectedItems
            let indexPath : NSIndexPath = iPath![0] as NSIndexPath
            let rowIndex = indexPath.row
            
            for (key, value) in bodyPaintingWorkshopArray[(rowIndex)].services{
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
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.generalServiceCollectionView{
            return genralWorkshopArray.count
        }
        
        if collectionView == self.bodyPaintingCollectionView{
            return bodyPaintingWorkshopArray.count
        }
        
        return 1
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.generalServiceCollectionView{
            let homeServiceCell = generalServiceCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeServiceCell
            homeServiceCell.serviceImage.sd_setImage(with: URL(string: genralWorkshopArray[indexPath.row].imageUrl))
            homeServiceCell.serviceStationName.text = genralWorkshopArray[indexPath.row].name
            SVProgressHUD.dismiss() 
            return homeServiceCell
        }
        
        if collectionView == self.bodyPaintingCollectionView{
            let paintingServiceCell = bodyPaintingCollectionView.dequeueReusableCell(withReuseIdentifier:"bodyPaintingCell", for: indexPath) as! HomeBodyPaintingCell
            paintingServiceCell.serviceImage.sd_setImage(with: URL(string: bodyPaintingWorkshopArray[indexPath.row].imageUrl))
            paintingServiceCell.serviceStationName.text = bodyPaintingWorkshopArray[indexPath.row].name
            SVProgressHUD.dismiss()
            return paintingServiceCell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == generalServiceCollectionView{
            self.name = genralWorkshopArray[indexPath.row].name
            self.img1 = genralWorkshopArray[indexPath.row].img1
            self.img2 = genralWorkshopArray[indexPath.row].img2
            self.img3 = genralWorkshopArray[indexPath.row].img3
            for (key, value) in genralWorkshopArray[indexPath.row].services{
                self.serviceName.append(key)
//                self.servicePrice.append(value)
            }
            performSegue(withIdentifier: "collectionGeneralService", sender: self)
            self.serviceName.removeAll()
            self.servicePrice.removeAll()
        }
        
        if collectionView == bodyPaintingCollectionView{
            self.name = bodyPaintingWorkshopArray[indexPath.row].name
            self.img1 = bodyPaintingWorkshopArray[indexPath.row].img1
            self.img2 = bodyPaintingWorkshopArray[indexPath.row].img2
            self.img3 = bodyPaintingWorkshopArray[indexPath.row].img3
            for (key, value) in bodyPaintingWorkshopArray[indexPath.row].services{
                self.serviceName.append(key)
//                self.servicePrice.append(value)
            }
            performSegue(withIdentifier: "collectionBodyPainitngService", sender: self)
            self.serviceName.removeAll()
            self.servicePrice.removeAll()
        }
       
    }
    
}



