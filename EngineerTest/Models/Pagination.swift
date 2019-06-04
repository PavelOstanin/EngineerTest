//
//  Pagination.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import ObjectMapper

class Pagination: Mappable {
    
    var hasMore:   Bool = false
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        hasMore <- map["has_more"]
    }
    
}
