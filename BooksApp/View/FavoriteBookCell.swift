//
//  FavoriteBookCell.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/12/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

protocol RemoveFavoriteDelegate {
    func removeFavoriteTapped(at indexPath: IndexPath)
}

class FavoriteBookCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    var delegate: RemoveFavoriteDelegate!
    var indexPath: IndexPath!
    var isFavorite = false
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Handlers
    @IBAction func removeFavoritesTapped(_ sender: Any) {
        self.delegate.removeFavoriteTapped(at: indexPath)
    }
    
}
