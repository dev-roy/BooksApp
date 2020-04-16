//
//  BookManager.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/15/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import CoreData

class BookManager {
    
    // MARK: - Properties
    static let shared = BookManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - CoreData methods
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
    
    func deleteMatches(at indexPath: IndexPath, bookModelArray: inout [BookModel], booksArray: inout [Book]) {
        bookModelArray = BookManager.shared.loadBooks(bookModelArray: &bookModelArray)
        for item in bookModelArray {
            if item.title == booksArray[indexPath.row].title {
                context.delete(item)
            }
        }
    }
    
    func deleteFromCoreData(at indexPath: IndexPath, bookModelArray: inout [BookModel]) {
        context.delete(bookModelArray[indexPath.row])
    }
    
    func filterArray(booksArray: inout [Book], bookModelArray: inout [BookModel]) -> [Book] {
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
