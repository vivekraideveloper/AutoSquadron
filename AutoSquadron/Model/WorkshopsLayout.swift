//
//  WorkshopsLayout.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 04/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import FirebaseDatabase

class WorkshopsLayout {
    
    let key: String!
    
    var name: String!
    var imageUrl: String!
    var img1: String!
    var img2: String!
    var img3: String!
    var services: [String: String]!
    var shortDesc: String!
    
    var itemRef: DatabaseReference?
    
    init(name: String, imageUrl: String, shortDesc: String, key: String, img1: String, img2: String, img3: String, services: Dictionary<String, String>) {
        self.name = name
        self.imageUrl = imageUrl
        self.shortDesc = shortDesc
        self.key = key
        self.img1 = img1
        self.img2 = img2
        self.img3 = img3
        self.services = services
        self.itemRef = nil
    }
    
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let url = snapshotValue?["imageUrl"] as? String {
            imageUrl = url
            
        }else{
            imageUrl = ""
        }
        
        if let workshopName = snapshotValue?["name"] as? String{
            name = workshopName
        }else{
            name = ""
        }
        
        if let sDesc = snapshotValue?["shortDesc"] as? String{
            shortDesc = sDesc
        }else{
            shortDesc = ""
        }
        if let image1 = snapshotValue?["img1"] as? String{
            img1 = image1
        }else{
            img1 = ""
        }
        if let image2 = snapshotValue?["img2"] as? String{
            img2 = image2
        }else{
            img2 = ""
        }
        if let image3 = snapshotValue?["img3"] as? String{
            img3 = image3
        }else{
            img3 = ""
        }
        
        if let servicesDictionary = snapshotValue?["services"] as? Dictionary<String, String>{
            services = servicesDictionary
        }else{
            services = [:]
            
        }
    }
    
    
}
