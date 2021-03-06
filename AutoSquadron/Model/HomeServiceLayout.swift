//
//  HomeServiceLayout.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 09/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct HomeServiceLayout {
    
    let key: String!
    let imageUrl: String!
    let name: String!
    
    let itemRef: DatabaseReference?
    
    init(url: String, key: String, name: String) {
        self.key = key
        self.imageUrl = url
        self.name = name
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let image_url = snapshotValue?["imageUrl"] as? String {
            imageUrl = image_url
            
        }else{
            imageUrl = ""
        }
        
        if let _name = snapshotValue?["name"] as? String {
            name = _name
            
        }else{
            name = ""
        }
    }
}
