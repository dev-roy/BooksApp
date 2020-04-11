//
//  BookCell.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/11/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

protocol ButtonDelegate {
    func addToFavoritesTapped(at index: IndexPath)
}

class BookCell: UITableViewCell {

    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    var delegate: ButtonDelegate!
    var indexPath: IndexPath!
    var isFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addToFavoritesTapped(_ sender: Any) {
        isFavorite = !isFavorite
        if isFavorite {
            favoritesButton.setTitle("Added", for: .normal)
            favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
           favoritesButton.setTitle("Add to favorites", for: .normal)
           favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        self.delegate.addToFavoritesTapped(at: indexPath)
    }
}
