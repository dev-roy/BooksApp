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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var bookModel: BookModel = {
        let bookModel = BookModel(context: context)
        bookModel.title = "A Song of Fire and Ice"
        bookModel.author = "George R. Martin"
        bookModel.thumbnailURL = "www.google.com"
        bookModel.bookDescription = "Very good book"
        bookModel.publisher = "Publishing House"
        bookModel.isFavorite = false
        return bookModel
    }()
    let book: Book = {
        let book = Book()
        book.title = "A Song of Fire and Ice"
        book.author = "George R. Martin"
        book.thumbnailURL = "www.google.com"
        book.description = "Very good book"
        book.publisher = "Publishing House"
        book.isFavorite = false
        return book
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterFavorites() {
        XCTAssertFalse(book.isFavorite)
        
        if book.title == bookModel.title && book.author == bookModel.author {
            book.isFavorite = true
        }
        
        XCTAssertTrue(book.isFavorite)
    }
    
    func testBookViewModel() {
        let bookViewModel = BookViewModel(book: book)
        XCTAssertEqual(book.title, bookViewModel.title)
        XCTAssertEqual(book.author, bookViewModel.author)
        XCTAssertEqual(book.thumbnailURL, bookViewModel.thumbnailURL)
        XCTAssertEqual(book.description, bookViewModel.description)
        XCTAssertEqual(book.publisher, bookViewModel.publisher)
        XCTAssertEqual(book.isFavorite, bookViewModel.isFavorite)
    
    }

}
