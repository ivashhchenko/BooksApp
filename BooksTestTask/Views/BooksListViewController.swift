//
//  ViewController.swift
//  BooksTestTask
//
//  Created by artem on 04.01.2023.
//

import UIKit

class BooksListViewController: UIViewController {
    
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BooksConnectService.shared.loadBooks(name: "Harry", completion: {result in
            guard let booksListResponse = result as? BooksListResponse,
                  let books = booksListResponse.items else { return }
            
            self.books = books
            print(books[1].image)
        })
        
    
    }


}
