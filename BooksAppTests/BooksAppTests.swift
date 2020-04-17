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

    func testCreateNewBook() {
        let book = Book()
        book.author = "George R. Martin"
        
    }

}
