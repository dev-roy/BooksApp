//
//  BookViewModel.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/16/20.
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
    
    init(title: String, author: String, thumbnailURL: String, publisher: String, description: String, isFavorite: Bool) {
        self.title = title
        self.author = author
        self.thumbnailURL = thumbnailURL
        self.publisher = publisher
        self.description = description
        self.isFavorite = isFavorite
    }
}
