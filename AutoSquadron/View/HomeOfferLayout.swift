//
//  HomeOfferLayout.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 30/09/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct HomeOfferLayout {
    
    let key: String!
    let url: String!
    
    let itemRef: DatabaseReference?
    
    init(url: String, key: String) {
        self.key = key
        self.url = url
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageUrl = snapshotValue?["url"] as? String {
            url = imageUrl
            
        }else{
            url = ""
        }
    }
}
