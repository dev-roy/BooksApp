//
//  BooksTableViewController.swift
//  BooksApp
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import NVActivityIndicatorView

class BooksTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    let cellId = "BookCell"
    var books = [Book]()
    var bookModels = [BookModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var removedFavorites = false
    var query = ""
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loadBooks()
        bookModels = BookManager.shared.loadBooks(bookModelArray: &bookModels)
        if removedFavorites {
            searchBook(query)
            removedFavorites = false
        }
    }
    
    // MARK: - Handlers
    func searchBook(_ bookTitle: String) {
        books = []
        startAnimating(CGSize(width: 60, height: 60), type: NVActivityIndicatorType.ballZigZag, color: .systemGreen)
        NetworkManager.shared.fetchBooks(bookTitle: bookTitle) { (success, books) in
            if success {
                if books.isEmpty {
                    self.stopAnimating()
                    let alert = UIAlertController(title: "No results found", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.books = books
                    self.books = BookManager.shared.filterArray(booksArray: &self.books, bookModelArray: &self.bookModels)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.stopAnimating()
                    }
                }
            } else {
                self.stopAnimating()
                let alert = UIAlertController(title: "Please make sure you have internet connection", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookCell
        cell.delegate = self
        cell.indexPath = indexPath
        let thumbnailURL = URL(string: books[indexPath.row].thumbnailURL)
        if let url = thumbnailURL {
            cell.bookThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.bookThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: "white"))
        }
        cell.bookTitle.text = books[indexPath.row].title
        cell.bookAuthor.text = "Author: \(books[indexPath.row].author)"
        cell.bookPublisher.text = "Publisher: \(books[indexPath.row].publisher)"
        if books[indexPath.row].isFavorite {
            cell.favoritesButton.setTitle("Added", for: .normal)
            cell.favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cell.isFavorite = true
        } else {
            cell.favoritesButton.setTitle("Add to favorites", for: .normal)
            cell.favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
            cell.isFavorite = false
        }
        return cell
    }
}

// MARK: Extensions

// MARK: - SearchBar Methods
extension BooksTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBook(searchBar.text!)
            query = searchBar.text!
        }
        view.endEditing(true)
    }
}

// MARK: - CellButton Methods
extension BooksTableViewController: AddFavoriteDelegate {
    func addToFavoritesTapped(at indexPath: IndexPath, isFavorite: Bool) {
        if isFavorite {
            let bookModel = BookModel(context: context)
            bookModel.title = books[indexPath.row].title
            bookModel.author = books[indexPath.row].author
            bookModel.publisher = books[indexPath.row].publisher
            bookModel.thumbnailURL = books[indexPath.row].thumbnailURL
            bookModel.bookDescription = books[indexPath.row].description
            bookModel.isFavorite = true
            BookManager.shared.saveContext()
        } else {
            BookManager.shared.deleteMatches(at: indexPath, bookModelArray: &bookModels, booksArray: &books)
        }
    }
}
