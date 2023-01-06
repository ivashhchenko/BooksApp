//
//  BooksRequest.swift
//  BooksTestTask
//
//  Created by artem on 05.01.2023.
//

import Foundation
import Alamofire // BooksRequestConverible

enum BooksRequestConverible: URLRequestConvertible {
    
    enum Constants {
        static let BaseUrlPath = "https://www.googleapis.com/books/v1"
    }
    
    case volumes(String)
    
    var method: HTTPMethod {
        switch self {
        case .volumes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .volumes:
            return "/volumes"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .volumes(let query):
            return ["q" : query]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.BaseUrlPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
