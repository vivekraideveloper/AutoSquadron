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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var customLayout: CustomImageFlowLayout!
    var collectionImages = [HomeOfferLayout]()
    
    var databaseReference: DatabaseReference!
    
    var images = ["1", "2","3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = Database.database().reference().child("offerImageUrl")
        
        pageControlSwipe()
        
        loadCollectionViewImages()
        
        customLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = customLayout
        collectionView.backgroundColor = .gray
        
        
    }
    
    func loadCollectionViewImages() {
       
        databaseReference.observe(DataEventType.value, with: { (snapshot) in
            
            var newImages = [HomeOfferLayout]()
            
            for offerSnapshot in snapshot.children{
                let offerObject = HomeOfferLayout(snapshot: offerSnapshot as! DataSnapshot)
                newImages.append(offerObject)
                
            }
            self.collectionImages = newImages
            self.collectionView.reloadData()
        })
    }
    
    func pageControlSwipe() {
        
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
    
    
    
}

extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell{
            let images = collectionImages[indexPath.row]
            cell.imageView.sd_setImage(with: URL(string: images.url), placeholderImage: UIImage(named: "1"))
            return cell
        }else{
            return UICollectionViewCell()
        }
       
    }
}










