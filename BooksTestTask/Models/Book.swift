//
//  File.swift
//  BooksTestTask
//
//  Created by artem on 06.01.2023.
//

import Foundation
import ObjectMapper

class Book: Mappable {
    
    var id: String!
    var title: String!
    var authors: [String]?
    var imageLink: String!
    var description: String?
    var link: String!
    
    required init(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["volumeInfo.title"]
        authors <- map["volumeInfo.authors"]
        description <- map["volumeInfo.description"]
        link <- map["volumeInfo.previewLink"]
        imageLink <- map["volumeInfo.imageLinks.thumbnail"]
    }
}
