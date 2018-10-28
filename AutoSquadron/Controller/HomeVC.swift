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

class HomeVC: UIViewController, UIScrollViewDelegate {

//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var collectionView: UICollectionView
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var generalServiceCollectionView: UICollectionView!
    @IBOutlet weak var bodyPaintingCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    var homeServiceItemArray = [HomeServiceLayout]()
    
    var customLayout: CustomImageFlowLayout!
    var collectionImages = [HomeOfferLayout]()
    
    var databaseReference: DatabaseReference!
    
//    Workshops
    var workshDatabaseReference: DatabaseReference!
    var workshopData = [WorkshopsLayout]()

    
    var images = ["1", "2","3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = Database.database().reference().child("offerImageUrl")
        
        
        workshDatabaseReference = Database.database().reference().child("genralServiceWorkshops")
        
        loadWorkshops()
       
        
        pageControlSwipe()
        
        loadGeneralService()
        loadBodyPaintingService()
        
        customLayout = CustomImageFlowLayout()
//        collectionView.collectionViewLayout = customLayout
//        collectionView.backgroundColor = .gray
        

    }
    
//    func loadCollectionViewImages() {
//
//        databaseReference.observe(DataEventType.value, with: { (snapshot) in
//
//            var newImages = [HomeOfferLayout]()
//
//            for offerSnapshot in snapshot.children{
//                let offerObject = HomeOfferLayout(snapshot: offerSnapshot as! DataSnapshot)
//                newImages.append(offerObject)
//
//            }
//            self.collectionImages = newImages
//            self.collectionView.reloadData()
//        })
//    }
    
    
    
    func loadWorkshops() {
        workshDatabaseReference.observe(DataEventType.value, with: { (snapshot) in
            
            var newData = [WorkshopsLayout]()
            
            for dataSnapshot in snapshot.children{
                let dataObject = WorkshopsLayout(snapshot: dataSnapshot as! DataSnapshot)
                newData.append(dataObject)
                
            }
            self.workshopData = newData
            
        })
    }
    
    
    func loadGeneralService() {
        
        generalServiceCollectionView.delegate = self
        generalServiceCollectionView.dataSource = self
        
        databaseReference.observe(DataEventType.value, with: { (snapshot) in

            var newImages = [HomeServiceLayout]()

            for offerSnapshot in snapshot.children{
                let offerObject = HomeServiceLayout(snapshot: offerSnapshot as! DataSnapshot)
                newImages.append(offerObject)

            }
            self.homeServiceItemArray = newImages
            self.generalServiceCollectionView.reloadData()
        })
    }
    
    func loadBodyPaintingService() {
        
        bodyPaintingCollectionView.delegate = self
        bodyPaintingCollectionView.dataSource = self
        
        databaseReference.observe(DataEventType.value, with: { (snapshot) in
            
            var newImages = [HomeServiceLayout]()
            
            for offerSnapshot in snapshot.children{
                let offerObject = HomeServiceLayout(snapshot: offerSnapshot as! DataSnapshot)
                newImages.append(offerObject)
                
            }
            self.homeServiceItemArray = newImages
            self.bodyPaintingCollectionView.reloadData()
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
        
        performSegue(withIdentifier: "service", sender: self)
    }
    
    @IBAction func bodyPaintingButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "service", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "service"{
            
            let destinationVC = segue.destination as! HomeWorkshopsVC
            for i in workshopData{
                destinationVC.serviceType = "General Service"
                destinationVC.workshopNames.append(i.name)
                destinationVC.images.append(i.imageUrl)
                destinationVC.workshopDescription.append(i.shortDesc)
            }
            
            destinationVC.databaseReference = Database.database().reference().child("genralServiceWorkshops")

        }

    }
    
    
    
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionImages.count
        if collectionView == self.generalServiceCollectionView{
            return homeServiceItemArray.count
        }
        
        if collectionView == self.bodyPaintingCollectionView{
            return homeServiceItemArray.count
        }
        
        return 1
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell{
//            let images = collectionImages[indexPath.row]
//            cell.imageView.sd_setImage(with: URL(string: images.url), placeholderImage: UIImage(named: "1"))
//            return cell
//        }else{
//            return UICollectionViewCell()
//        }
        
        if collectionView == self.generalServiceCollectionView{
            let homeServiceCell = generalServiceCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeServiceCell
            homeServiceCell.serviceImage.sd_setImage(with: URL(string: homeServiceItemArray[indexPath.row].url))
            homeServiceCell.serviceStationName.text = homeServiceItemArray[indexPath.row].name
            return homeServiceCell
        }
        
        if collectionView == self.bodyPaintingCollectionView{
            let paintingServiceCell = bodyPaintingCollectionView.dequeueReusableCell(withReuseIdentifier:"bodyPaintingCell", for: indexPath) as! HomeBodyPaintingCell
            paintingServiceCell.serviceImage.sd_setImage(with: URL(string: homeServiceItemArray[indexPath.row].url))
            paintingServiceCell.serviceStationName.text = homeServiceItemArray[indexPath.row].name
            return paintingServiceCell
        }
        
        return UICollectionViewCell()
        
       

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
    }
    
    
    
}










