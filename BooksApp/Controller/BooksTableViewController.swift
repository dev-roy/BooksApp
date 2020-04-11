//
//  BooksTableViewController.swift
//  BooksApp
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SDWebImage

class BooksTableViewController: UITableViewController {
    let cellId = "BookCell"
    var books = [Book]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(BookCell.self, forCellReuseIdentifier: cellId)
        loadTableView()
    }
    
    func loadTableView() {
        NetworkManager.shared.fetchBooks(bookTitle: "Harry Potter") { (success, books) in
            if success {
                self.books = books
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func searchBook(_ bookTitle: String) {
        books = []
        NetworkManager.shared.fetchBooks(bookTitle: bookTitle) { (success, books) in
            if success {
                self.books = books
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let book = books[indexPath.row]
                let controller = segue.destination as! BookDetailViewController
                controller.detailBook = book
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.delegate = self
        cell.indexPath = indexPath
        let thumbnailURL = URL(string: books[indexPath.row].thumbnailURL)
        if let url = thumbnailURL {
            cell.bookThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.bookThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
        }
        cell.bookTitle.text = books[indexPath.row].title
        cell.bookAuthor.text = "Author: \(books[indexPath.row].author)"
        cell.bookPublisher.text = "Publisher: \(books[indexPath.row].publisher)"
        return cell
    }
}

extension BooksTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBook(searchBar.text!)
        }
        view.endEditing(true)
    }
}

extension BooksTableViewController: ButtonDelegate {
    func addToFavoritesTapped(at index: IndexPath) {
        print(books[index.row])
    }
}
