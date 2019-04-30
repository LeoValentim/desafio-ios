//
//  MovieCell.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: CustomImage!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var favoriteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.16
        cardView.layer.shadowRadius = 6
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func setModel(_ model: MovieViewModel, favoriteAction: (() -> Void)?) {
        titleLabel.text = model.title
        
        if let imageUrl = model.imageURL {
            imageView.loadAndCacheImage(from: imageUrl)
        }
        
        if model.isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        
        self.favoriteAction = favoriteAction
    }

    @IBAction func favoriteAction(_ sender: Any) {
    }
}
