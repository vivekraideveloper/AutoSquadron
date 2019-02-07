//
//  WorkshopDetailVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 07/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import RealmSwift
import ImageSlideshow

class WorkshopDetailVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var images = [String]()
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var _workshopName: String?  
    var serviceNameArray: [String] = []
    var servicePriceArray: [String] = []
    var serviceDetailArray: [String] = []
    let realm = try! Realm()
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var workshopDetailTableView: UITableView!
    @IBOutlet weak var workshopName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workshopDetailTableView.delegate = self
        workshopDetailTableView.dataSource = self
        pageControlSwipe()
        loadData()
        print("***************************************")
        print(images[0])
        print(images[1])
        print(images[2])
        
        print(servicePriceArray)
        print(serviceDetailArray)
    }
    
    func loadData(){
        workshopName.text = _workshopName
    }
    
    func pageControlSwipe() {
        
        slideShow.layer.cornerRadius = 5
        slideShow.setImageInputs([
            SDWebImageSource(urlString: images[0], placeholder: UIImage(named: "5")!)!,
            SDWebImageSource(urlString: images[1], placeholder: UIImage(named: "5")!)!,
            SDWebImageSource(urlString: images[2], placeholder: UIImage(named: "5")!)!

            ])
        
        
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.white
        slideShow.pageIndicator = pageControl
        slideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 5))
        
//        pageControl.numberOfPages = images.count
//
//        for index in 0..<images.count{
//
//            frame.origin.x = scrollViewImages.frame.size.width*CGFloat(index)
//            frame.size = scrollViewImages.frame.size
//            let imageView = UIImageView(frame: frame)
//            imageView.sd_setImage(with: URL(string: images[index]))
//            self.scrollViewImages.addSubview(imageView)
//
//        }
//
//        scrollViewImages.contentSize = CGSize(width: scrollViewImages.frame.size.width*CGFloat(images.count), height: scrollViewImages.frame.size.height)
//        scrollViewImages.delegate = self
    }
    
    func saveCartData(data: CartData) {
        do{
           try realm.write {
                realm.add(data)
            }
        }catch{
            print("Error while saving data")
        }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = scrollViewImages.contentOffset.x/scrollViewImages.frame.size.width
//        pageControl.currentPage = Int(pageNumber)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkshopDetailCell
        cell.serviceName.text = serviceNameArray[indexPath.row]
        cell.servicePrice.text = "Rs" + servicePriceArray[indexPath.row]
        cell.infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let alertVC = UIAlertController(title: "Add this service to Cart?", message: nil, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
//
//            let cartData = CartData()
//            cartData.serviceName = self.serviceNameArray[indexPath.row]
//            cartData.servicePrice = self.servicePriceArray[indexPath.row]
//            cartData.workshopName = self._workshopName ?? "VivekRai"
//            self.saveCartData(data: cartData)
//
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
//        }
//
//        alertVC.addAction(okAction)
//        alertVC.addAction(cancelAction)
//        self.present(alertVC, animated: true, completion: nil)
//        self.workshopDetailTableView.deselectRow(at: indexPath, animated: true)
        
        
        performSegue(withIdentifier: "userDetail", sender: self)
        
    }
    
    
    @objc func infoButtonPressed() {
        let alertController = UIAlertController(title: _workshopName, message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetail"{
            let destinationVC = segue.destination as! UserServiceDetailVC
            destinationVC.serviceNameText = serviceNameArray[(workshopDetailTableView.indexPathForSelectedRow?.row)!]
            destinationVC.serviceStationNameText = _workshopName
            destinationVC.servicePriceText = "Total Price - Rs" + servicePriceArray[(workshopDetailTableView.indexPathForSelectedRow?.row)!]
            destinationVC.serviceDetailText = serviceDetailArray[(workshopDetailTableView.indexPathForSelectedRow?.row)!]
        
//            destinationVC.images.append(img1)
//            destinationVC.images.append(img2)
//            destinationVC.images.append(img3)
//            destinationVC.serviceNameArray = serviceName
//            destinationVC.servicePriceArray = servicePrice
        }
    }
}


