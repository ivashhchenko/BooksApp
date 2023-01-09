//
//  String.swift
//  BooksTestTask
//
//  Created by artem on 05.01.2023.
//

import Foundation


extension String {
    
    public func urlEncode(string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
