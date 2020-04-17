//
//  ViewController.swift
//  BooksApp
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SDWebImage

class BookDetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var detailBook: BookViewModel? {
        didSet {
            configureView()
        }
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let book = detailBook {
            if let thumbmnail = bookImage {
                let thumbnailURL = URL(string: book.thumbnailURL)
                if let url = thumbnailURL {
                    thumbmnail.sd_setImage(with: url, placeholderImage: UIImage(named: "white"))
                }
            }
            if let title = bookTitle {
                title.text = "Title: \(book.title)"
            }
            if let author = bookAuthor {
                author.text = "Author: \(book.author)"
            }
            if let publisher = bookPublisher {
                publisher.text = "Publisher: \(book.publisher)"
            }
            if let description = bookDescription {
                description.text = "Description: \(book.description)"
            }
            if let date = dateLabel {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                let currentDate = Date()
                date.text = "Date requested: \(formatter.string(from: currentDate as Date))"
            }
        }
    }
}

