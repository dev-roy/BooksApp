//
//  NetworkManager.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    
    
    func fetchBooks(bookTitle: String, completion: @escaping(_ success: Bool, _ arr: [Book]) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let queryString = bookTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            AF.request("https://www.googleapis.com/books/v1/volumes?q=\(queryString)/maxResults=40").validate().responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let json: JSON = JSON(data)
                    let subjson: JSON = json["items"]
                    var booksArray = [Book]()
                    for (_, object) in subjson {
                        let book = Book ()
                        book.title = object["volumeInfo"]["title"].stringValue
                        let authorsArray = object["volumeInfo"]["authors"].arrayObject as? [String] ?? [""]
                        book.author = authorsArray.joined(separator: ", ")
                        book.thumbnailURL = object["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                        book.publisher = object["volumeInfo"]["publisher"].stringValue
                        book.description = object["volumeInfo"]["description"].stringValue
                        booksArray.append(book)
                    }
                    completion(true, booksArray)
                    
                case .failure(let error):
                    completion(false, [])
                    print(error)
                    break
                }
            }
        }
    }
}
