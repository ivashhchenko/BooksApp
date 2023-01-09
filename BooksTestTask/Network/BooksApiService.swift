//
//  BooksConnection.swift
//  BooksTestTask
//
//  Created by artem on 05.01.2023.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class BooksApiService {
    
    static let shared = BooksApiService()
    
    public func loadBooks(name: String, completion: @escaping (Any?) -> Void) {
        guard let parameterString = name.urlEncode(string: name) else {
            completion(nil)
            return
        }
        
        AF.request(BooksRequest.volumes(parameterString)).responseObject {(response: AFDataResponse<BooksResponse>) in
            
            guard let value = response.value else {
                completion(nil)
                return
            }
            
            completion(value)
            
        }
    
    }
    
    private init() {}
    
    
    
    
}
