//
//  FavoritesTableViewController.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class FavoritesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var bookModelArray = [BookModel]()
    let cellId = "FavoriteBookCell"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                guard let title = bookModelArray[indexPath.row].title else { return }
                guard let author = bookModelArray[indexPath.row].author else { return }
                guard let thumbnailURL = bookModelArray[indexPath.row].thumbnailURL else { return }
                guard let publisher = bookModelArray[indexPath.row].publisher else { return }
                guard let description = bookModelArray[indexPath.row].bookDescription else { return }
                let book = Book()
                book.title = title
                book.author = author
                book.publisher = publisher
                book.thumbnailURL = thumbnailURL
                book.description = description
                let controller = segue.destination as! BookDetailViewController
                controller.detailBook = book
            }
        }
    }
    
    // MARK: - CoreData methods
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
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
        BookManager.shared.saveContext()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        let booksVC = self.tabBarController?.viewControllers?[0] as! BooksTableViewController
        booksVC.removedFavorites = true
    }
}


