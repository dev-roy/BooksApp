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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchBooks(bookTitle: String, completion: @escaping(_ success: Bool, _ arr: [Book]) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let queryString = bookTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            AF.request("https://www.googleapis.com/books/v1/volumes?q=\(queryString)").validate().responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let json: JSON = JSON(data)
                    let subjson: JSON = json["items"]
                    var booksArray = [Book]()
                    for (_, object) in subjson {
                        let title = object["volumeInfo"]["title"].stringValue
                        let authorsArray = object["volumeInfo"]["authors"].arrayObject as! [String]
                        let author = authorsArray.joined(separator: ", ")
                        let thumbnailURL = object["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                        let publisher = object["volumeInfo"]["publisher"].stringValue
                        let description = object["volumeInfo"]["description"].stringValue
                        let book = Book(title: title, author: author, thumbnailURL: thumbnailURL, publisher: publisher, description: description, isFavorite: false)
                        booksArray.append(book)
                    }
                    completion(true, booksArray)
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
