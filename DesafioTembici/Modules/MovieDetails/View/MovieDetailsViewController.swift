//
//  MovieDetailsViewController.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

// MARK: - View
class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: CustomImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var presenter: MoviesDetailsOutput?
    var model: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isHidden = false
    }

    @IBAction func favoriteAction(_ sender: Any) {
        guard let model = model else {return}
        LoadingView.shared.hud.show(in: view)
        presenter?.setFavoriteMovie(model)
    }
}

// MARK: - View configuration methods
extension MovieDetailsViewController {
    func setupViews() {
        title = model?.title
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        if let url = model?.imageURL {
            imageView.loadAndCacheImage(from: url)
        }
        
        titleLabel.text = model?.title
        dateLabel.text = model?.releaseDate?.toString(withFormat: "yyyy")
        categoryLabel.text = model?.genres.filter({ $0.name != nil }).map({ $0.name! }).joined(separator: ", ")
        descriptionLabel.text = model?.overview
        
        if model?.isFavorite == true {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
}

// MARK: - View / Presenter
protocol MovieDetailsInput: class {
    func didFavoriteMovie()
    func didFailure(_ error: Error)
}
extension MovieDetailsViewController: MovieDetailsInput {
    func didFavoriteMovie() {
        LoadingView.shared.hud.dismiss()
        let oldValue = model?.isFavorite ?? false
        model?.isFavorite = !oldValue
        
        if model?.isFavorite == true {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
    
    func didFailure(_ error: Error) {
        LoadingView.shared.hud.dismiss()
        print("error: \(error)")
    }
}

