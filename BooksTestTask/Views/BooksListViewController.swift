//
//  ViewController.swift
//  BooksTestTask
//
//  Created by artem on 04.01.2023.
//


import UIKit
import SnapKit

class BooksListViewController: UIViewController {
    
    var books = [Book]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        
        return spinner
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConstraints()
        resultTableView.isHidden = true
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        searchTextField.delegate = self

    }
    
    func startSpinning() {
        view.addSubview(spinner)
        spinner.alpha = 1
        spinner.startAnimating()
        
    }
    
    func stopSpinning() {
        spinner.alpha = 0
        //spinner.removeFromSuperview()
        spinner.stopAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.cancelSearch()
    }
    

    @IBAction func searchTextFieldTouchInsideAction(_ sender: Any) {
        animateSearchTextField()
    }
    
    @IBAction func searchTextFieldReturnAction(_ sender: Any) {
        startSpinning()
        
        BooksApiService.shared.loadBooks(name: self.searchTextField.text!, completion: { result in
            guard let volumeListResponse = result as? BooksResponse,
                    let volumes = volumeListResponse.items else {
                return
            }
            
            self.books = volumes
            self.resultTableView.reloadData()
            self.stopSpinning()
            self.resultTableView.isHidden = false
        })
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        animateCancelButton()
        self.searchTextField.text = ""
        
        if !books.isEmpty {
            self.books = []
            self.resultTableView.reloadData()
        }
    }
    
    
    func animateSearchTextField() {
      
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 1
            self.cancelButton.snp.updateConstraints {make in
                make.trailing.equalTo(self.searchTextField).inset(10)
            }
            
            self.searchLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(-50)
            }
            
            self.searchTextField.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(60)
                
            }
            
            self.view.layoutIfNeeded()
        })

    }
    
    func cancelSearch() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.snp.remakeConstraints { make in
                make.top.equalTo(self.searchTextField).inset(0)
                make.trailing.equalTo(self.searchTextField).inset(-self.cancelButton.frame.width * 2)
            }
            self.searchLabel.snp.removeConstraints()
            self.searchTextField.snp.removeConstraints()
            
            self.view.layoutIfNeeded()
        })
    }
    
    func animateCancelButton() {
        self.cancelButton.alpha = 0
        cancelSearch()
    }
    
    func updateConstraints() {
        //view.addSubview(spinner)
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.center.equalTo(self.view)
            
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField).inset(0)
            make.trailing.equalTo(searchTextField).inset(-cancelButton.frame.width * 2)
        }
    }
    
    func loadImage(url: String, imageView: UIImageView) {

        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let imageData = data {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData)!
                        
                    }
                }
            }.resume()
        } else {
            imageView.image = UIImage(named: "questionmark.folder")
        }
        
    }
    
    

}

extension BooksListViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        cell.clipsToBounds = true
        
        if !books.isEmpty {
            
            cell.bookTitle.text = books[indexPath.row].title
            cell.bookAuthor.text = books[indexPath.row].authors?.first
            cell.bookLink = books[indexPath.row].link
            
            //BookTableViewCell.bookLink = books[indexPath.row].link

            if let link = books[indexPath.row].imageLink {
                loadImage(url: link, imageView: cell.bookImage)
            } else {
                cell.bookImage.image = UIImage(named: "questionmark.folder")
            }
         
        } // Добавить сообщение о том, что книги не найдены
        
        return cell
    }


    
}
