//
//  BooksAppTests.swift
//  BooksAppTests
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import XCTest
@testable import BooksApp

class BooksAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterFavorites() {
        let book = Book()
        book.title = "A Song of Fire and Ice"
        book.author = "George R. Martin"
        book.thumbnailURL = "www.google.com"
        book.description = "Very good book"
        book.publisher = "Publishing House"
        book.isFavorite = false
        
        let favoriteBook = Book()
        favoriteBook.title = "A Song of Fire and Ice"
        favoriteBook.author = "George R. Martin"
        favoriteBook.thumbnailURL = "www.google.com"
        favoriteBook.description = "Very good book"
        favoriteBook.publisher = "Publishing House"
        favoriteBook.isFavorite = false
        
        var booksArray = [book]
        let bookModelArray = [favoriteBook]
        
        for book in booksArray {
            for bookModel in bookModelArray {
                if book.title == bookModel.title && book.author == bookModel.author {
                    book.isFavorite = true
                }
            }
            booksArray.append(book)
        }
        
        XCTAssertTrue(booksArray[1].isFavorite)
    }
    
    func testBookViewModel() {
        let book = Book()
        book.title = "A Song of Fire and Ice"
        book.author = "George R. Martin"
        book.thumbnailURL = "www.google.com"
        book.description = "Very good book"
        book.publisher = "Publishing House"
        book.isFavorite = false
        let bookViewModel = BookViewModel(book: book)
        XCTAssertEqual(book.title, bookViewModel.title)
        XCTAssertEqual(book.author, bookViewModel.author)
        XCTAssertEqual(book.thumbnailURL, bookViewModel.thumbnailURL)
        XCTAssertEqual(book.description, bookViewModel.description)
        XCTAssertEqual(book.publisher, bookViewModel.publisher)
        XCTAssertEqual(book.isFavorite, bookViewModel.isFavorite)
    
    }

}
