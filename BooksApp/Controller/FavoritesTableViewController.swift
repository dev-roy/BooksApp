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
    
    var books = [BookModel]()
    let cellId = "FavoriteBookCell"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBooks()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFavorite" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let title = books[indexPath.row].title else { return }
                guard let author = books[indexPath.row].author else { return }
                guard let thumbnailURL = books[indexPath.row].thumbnailURL else { return }
                guard let publisher = books[indexPath.row].publisher else { return }
                guard let description = books[indexPath.row].bookDescription else { return }
                let book = Book(title: title, author: author, thumbnailURL: thumbnailURL, publisher: publisher, description: description, isFavorite: true)
                let controller = segue.destination as! BookDetailViewController
                controller.detailBook = book
            }
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadBooks() {
        let request: NSFetchRequest<BookModel> = BookModel.fetchRequest()
        do {
            books = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FavoriteBookCell
        let thumbnailURL = URL(string: books[indexPath.row].thumbnailURL ?? "")
        cell.delegate = self
        cell.indexPath = indexPath
        if let url = thumbnailURL {
            cell.bookThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.bookThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
        }
        cell.bookTitle.text = books[indexPath.row].title
        cell.bookAuthor.text = books[indexPath.row].author
        cell.bookPublisher.text = books[indexPath.row].publisher
        return cell
    }
}

extension FavoritesTableViewController: RemoveFavoriteDelegate {
    func removeFavoriteTapped(at indexPath: IndexPath) {
        context.delete(books[indexPath.row])
        books.remove(at: indexPath.row)
        saveContext()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(indexPath.row)
    }
}
