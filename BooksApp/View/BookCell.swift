//
//  BookCell.swift
//  BooksApp
//
//  Created by Rodrigo Buendia Ramos on 4/11/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
