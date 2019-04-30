//
//  FavoriteCell.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var photoView: CustomImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setModel(_ model: MovieViewModel) {
        if let url = model.imageURL {
            photoView.loadAndCacheImage(from: url)
        }
        
        titleLabel.text = model.title
        descriptionLabel.text = model.overview
        dateLabel.text = model.releaseDate?.toString(withFormat: "yyyy")
    }
    
}
