//
//  FavoritesTableViewController.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var bookModelArray = [BookModel]()
    let cellId = "FavoriteBookCell"
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookModelArray = BookManager.shared.loadBooks(bookModelArray: &bookModelArray)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Handlers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFavorite" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let book = BookManager.shared.convertBookModelToBook(bookModel: bookModelArray[indexPath.row])
                let bookViewModel = BookViewModel(book: book)
                let controller = segue.destination as! BookDetailViewController
                controller.detailBook = bookViewModel
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookModelArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FavoriteBookCell
        let thumbnailURL = URL(string: bookModelArray[indexPath.row].thumbnailURL ?? "")
        cell.delegate = self
        cell.indexPath = indexPath
        if let url = thumbnailURL {
            cell.bookThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.bookThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: "white"))
        }
        cell.bookTitle.text = bookModelArray[indexPath.row].title
        cell.bookAuthor.text = bookModelArray[indexPath.row].author
        cell.bookPublisher.text = bookModelArray[indexPath.row].publisher
        return cell
    }
}

// MARK: - Extensions
extension FavoritesTableViewController: RemoveFavoriteDelegate {
    func removeFavoriteTapped(at indexPath: IndexPath) {
        BookManager.shared.deleteFromCoreData(at: indexPath, bookModelArray: &bookModelArray)
        bookModelArray.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        let navigationVC = self.tabBarController?.viewControllers?[0] as! UINavigationController
        let booksVC = navigationVC.viewControllers[0] as! BooksTableViewController
        booksVC.removedFavorites = true
    }
}


