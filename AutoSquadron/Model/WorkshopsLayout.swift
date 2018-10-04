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
    var shortDesc: String!
    
    var itemRef: DatabaseReference?
    
    init(name: String, imageUrl: String, shortDesc: String, key: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.shortDesc = shortDesc
        self.key = key
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
    }
    
    
}
