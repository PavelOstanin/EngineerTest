//
//  Item.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
    
    var image: String?
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        image <- map["image"]
    }
    
}

