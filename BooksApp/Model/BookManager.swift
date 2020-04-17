//
//  BookManager.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/15/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import CoreData

final class BookManager {
    
    // MARK: - Properties
    static let shared = BookManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - CoreData methods
    func saveNewFavoriteBook(title: String, author: String, publisher: String, thumbnailURL: String, description: String, isFavorite: Bool) {
        let bookModel = BookModel(context: context)
        bookModel.title = title
        bookModel.author = author
        bookModel.publisher = publisher
        bookModel.thumbnailURL = thumbnailURL
        bookModel.bookDescription = description
        bookModel.isFavorite = isFavorite
        saveContext()
    }
    
    func convertBookModelToBook(bookModel: BookModel) -> Book {
        let book = Book()
        if let title = bookModel.title {
            book.title = title
        }
        if let author = bookModel.author {
            book.author = author
        }
        if let thumbnailURL = bookModel.thumbnailURL {
            book.thumbnailURL = thumbnailURL
        }
        if let publisher = bookModel.publisher {
            book.publisher = publisher
        }
        if let description = bookModel.bookDescription {
            book.description = description
        }
        book.isFavorite = bookModel.isFavorite
        
        return book
    }
    
    func createNewBook(book: BookViewModel) {
        let bookModel = BookModel(context: context)
        bookModel.title = book.title
        bookModel.author = book.author
        bookModel.publisher = book.publisher
        bookModel.thumbnailURL = book.thumbnailURL
        bookModel.bookDescription = book.description
        bookModel.isFavorite = true
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadBooks(bookModelArray: inout [BookModel]) -> [BookModel] {
        let request: NSFetchRequest<BookModel> = BookModel.fetchRequest()
        do {
            bookModelArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return bookModelArray
    }
    
    func deleteMatches(at indexPath: IndexPath, bookModelArray: inout [BookModel], booksArray: inout [BookViewModel]) {
        bookModelArray = loadBooks(bookModelArray: &bookModelArray)
        for item in bookModelArray {
            if item.title == booksArray[indexPath.row].title {
                context.delete(item)
            }
        }
        saveContext()
    }
    
    func deleteFromCoreData(at indexPath: IndexPath, bookModelArray: inout [BookModel]) {
        context.delete(bookModelArray[indexPath.row])
        saveContext()
    }
    
    func filterArray(booksArray: inout [BookViewModel], bookModelArray: inout [BookModel]) -> [BookViewModel] {
        for book in booksArray {
            for bookModel in bookModelArray {
                if book.title == bookModel.title && book.author == bookModel.author {
                    book.isFavorite = true
                }
            }
            booksArray.append(book)
        }
        return booksArray
    }
}
