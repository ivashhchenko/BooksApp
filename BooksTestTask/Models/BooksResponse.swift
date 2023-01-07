// AIzaSyDqX5xgwMMM8GDPZKVsSM28qxrSgZmKPAw
import Foundation
import UIKit
import ObjectMapper

class BooksResponse: Mappable {

    var totalItems: Int!
    var items: [Book]?
    
    func mapping(map: Map) {
        totalItems <- map["totalItems"]
        items <- map["items"]
    }
    
    required init?(map: Map) {}
}




