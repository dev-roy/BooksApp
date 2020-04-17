//
//  BookViewModel.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/17/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation

class BookViewModel {
    
    var title: String
    var author: String
    var thumbnailURL: String
    var publisher: String
    var description: String
    var isFavorite: Bool
    
    init(book: Book) {
        self.title = book.title
        self.author = book.author
        self.thumbnailURL = book.thumbnailURL
        self.publisher = book.publisher
        self.description = book.description
        self.isFavorite = book.isFavorite
    }
    
    func convertToBook(bookModel: BookModel) -> BookViewModel {
        self.title = bookModel.title!
        self.author = bookModel.author!
        self.thumbnailURL = bookModel.thumbnailURL!
        self.publisher = bookModel.publisher!
        self.description = bookModel.description
        self.isFavorite = bookModel.isFavorite
        return self
    }
}
