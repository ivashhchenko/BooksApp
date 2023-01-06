//
//  String.swift
//  BooksTestTask
//
//  Created by artem on 05.01.2023.
//

import Foundation


extension String {
    
    public func normalizeForSearchParameter(string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
