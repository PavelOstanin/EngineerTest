//
//  AlamofireHelper.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//
import Foundation
import Alamofire
typealias successBlockAlamofire = (Any?) -> ()
typealias failureBlock = (NSError?) -> ()

class AlamofireHelper {
    
    private static let baseURL = "http://sd2-hiring.herokuapp.com/api/"
    
    
    class func alamofireRequestFromUrl(_ endpoint: String, params: Parameters?, method: HTTPMethod, success: @escaping successBlockAlamofire, failure: @escaping failureBlock) {
        let url = URL(string: baseURL + endpoint)!
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                #if DEBUG
                print("Str-> \(response.result.value ?? "")")
                #endif
                success(response.result.value)
            case .failure:
                #if DEBUG
                print("Error result -> \(response.error.debugDescription)")
                #endif
                failure(response.error as NSError?)
            }
        }
        
    }
    
}
