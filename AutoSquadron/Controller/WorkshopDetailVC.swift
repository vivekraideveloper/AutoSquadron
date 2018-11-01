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

class WorkshopDetailVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var images = [String]()
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var _workshopName: String?  
    var serviceNameArray: [String] = []
    var servicePriceArray: [String] = []
    
    @IBOutlet weak var workshopDetailTableView: UITableView!
    @IBOutlet weak var workshopName: UILabel!
    @IBOutlet weak var scrollViewImages: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workshopDetailTableView.delegate = self
        workshopDetailTableView.dataSource = self
        pageControlSwipe()
        loadData()
        scrollViewImages.layer.cornerRadius = 10
    }
    
    func loadData(){
        workshopName.text = _workshopName
    }
    
    func pageControlSwipe() {
        
        pageControl.numberOfPages = images.count
        
        for index in 0..<images.count{
            
            frame.origin.x = scrollViewImages.frame.size.width*CGFloat(index)
            frame.size = scrollViewImages.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.sd_setImage(with: URL(string: images[index]))
            self.scrollViewImages.addSubview(imageView)
            
        }
        
        scrollViewImages.contentSize = CGSize(width: scrollViewImages.frame.size.width*CGFloat(images.count), height: scrollViewImages.frame.size.height)
        scrollViewImages.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollViewImages.contentOffset.x/scrollViewImages.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkshopDetailCell
        cell.serviceName.text = serviceNameArray[indexPath.row]
        cell.servicePrice.text = "Rs " + servicePriceArray[indexPath.row]
        cell.infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(serviceNameArray[(workshopDetailTableView.indexPathForSelectedRow?.row)!])
        
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
    
}
