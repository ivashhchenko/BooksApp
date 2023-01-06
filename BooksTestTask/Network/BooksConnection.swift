//
//  BooksConnection.swift
//  BooksTestTask
//
//  Created by artem on 05.01.2023.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class BooksConnectService {
    
    static let shared = BooksConnectService()
    
    public func loadBooks(name: String, completion: @escaping (Any?) -> Void) {
        guard let parameterString = name.normalizeForSearchParameter(string: name) else {
            completion(nil)
            return
        }
        
        AF.request(BooksRequestConverible.volumes(parameterString)).responseObject {(response: AFDataResponse<BooksListResponse>) in
            
            guard let value = response.value else {
                completion(nil)
                return
            }
            
            completion(value)
            
        }
    
    }
    
    private init() {}
    
    
    
    
}
