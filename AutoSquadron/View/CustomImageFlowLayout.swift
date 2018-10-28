//
//  CustomImageFlowLayout.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 21/09/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {
    
    var homeServiceItemArray = [HomeServiceLayout]()
    
    override init() {
        super.init()
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    override var itemSize: CGSize{
        set{}
        
        get{
            let numberOfColumns: CGFloat = CGFloat(homeServiceItemArray.count)
            let itemWidth =  ((self.collectionView?.frame.width)! - (numberOfColumns-1)) / numberOfColumns
            return CGSize(width: itemWidth, height: 100)
            
        }
    }
    
    func setUpLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
