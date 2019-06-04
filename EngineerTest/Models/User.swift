//
//  User.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var name: String?
    var image: String?
    var items: [Item?] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name  <- map["name"]
        image <- map["image"]
        if let itemsArray = map.JSON["items"] as? [String] {
            for i in itemsArray {
                let item = Item()
                item.image = i
                items.append(item)
            }
        }
    }
    
}
