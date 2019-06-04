//
//  UsersDataSource.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

let limit: Int = 10

protocol UsersDataSourceDelegate: class {
    func didUpdateUsers()
}

class UsersDataSource {
    
    weak var delegate: UsersDataSourceDelegate?
    
    var users: [User?] = []
    var hasMore: Bool = true
    var isLoading: Bool = false
    
    
    func loadMoreUsers() {
        if !isLoading && hasMore {
            isLoading = true
            let parameters = ["offset" : users.count, "limit" : limit]
            AlamofireHelper.alamofireRequestFromUrl("users", params: parameters, method: .get, success: { (result) in
                self.isLoading = false
                guard let json = result as? [String: Any], let data = json["data"] as? [String: Any]  else {return}
                let map = Map.init(mappingType: .fromJSON, JSON: data)
                let pagination = Pagination(map: map)
                var users: [User?] = []
                if let jsonUsers = data["users"] as? [[String: Any]] {
                    for u in jsonUsers {
                        let map = Map.init(mappingType: .fromJSON, JSON: u)
                        users.append(User(map: map))
                    }
                }
                self.users.append(contentsOf: users)
                self.hasMore = pagination?.hasMore ?? false
                self.delegate?.didUpdateUsers()
            }) { (error) in
                self.isLoading = false
            }
        }
        
    }
    
    
}
