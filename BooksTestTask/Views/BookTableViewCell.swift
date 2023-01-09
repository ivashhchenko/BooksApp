//
//  BookTableViewCell.swift
//  BooksTestTask
//
//  Created by artem on 06.01.2023.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookLinkLabel: UILabel!
    
    var bookLink = "https://books.google.com/"
    
    var attributedString = NSMutableAttributedString()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookTitle.numberOfLines = 2
        addGesture()
        createClickableLink()
        
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickLink(sender:)))
        bookLinkLabel.isUserInteractionEnabled = true
        bookLinkLabel.addGestureRecognizer(tap)
    }
    
    func createClickableLink() {
        attributedString = NSMutableAttributedString(string: "Нажмите для просмотра")
        attributedString.addAttribute(.link, value: bookLink, range: NSRange(location: 1, length: 5))
        bookLinkLabel.attributedText = attributedString

    }
    
    
    @objc func clickLink(sender: UITapGestureRecognizer) {
        openUrl(url: bookLink)
    }
    
    func openUrl(url: String!) {
        if let url = URL(string: url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else { print("Не удалось конвертировать ссылку") }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
