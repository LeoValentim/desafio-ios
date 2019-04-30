//
//  Movie+ViewModel.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation
import RealmSwift

typealias MovieViewModel = Movie.Model.ViewModel

extension Movie.Model {
    struct ViewModel {
        let id: Int?
        let title: String
        let originalLanguage: String?
        let overview: String?
        let releaseDate: Date?
        let imageURL: URL?
        let genreIDS: [Int]?
        
        var isFavorite: Bool
        var genres: [GenreViewModel] = []
        
        init(from model: Movie) {
            id = model.id
            title = model.title ?? ""
            releaseDate = model.releaseDate?.toDate(withFormat: "yyyy-MM-dd")
            originalLanguage = model.originalLanguage ?? ""
            overview = model.overview ?? ""
            isFavorite = false
            genreIDS = model.genreIDS
            
            if let urlPhoto = model.posterPath {
                imageURL = URL(string: "\(Constants.API.themoviedb.URL.imageURL.rawValue)\(urlPhoto)")
            } else {
                imageURL = nil
            }
        }
        
        init(from localModel: MovieLocal) {
            id = localModel.movieId
            title = localModel.title
            originalLanguage = localModel.originalLanguage
            overview = localModel.overview
            releaseDate = localModel.releaseDate
            isFavorite = localModel.isFavorite
            genreIDS = localModel.genreIDS.map({ $0 })
            
            if let urlString = localModel.imageURL {
                imageURL = URL(string: urlString)
            } else {
                imageURL = nil
            }
        }
        
        func toLocalModel() -> MovieLocal {
            let localModel = MovieLocal()
            localModel.movieId = id ?? 0
            localModel.title = title
            localModel.originalLanguage = originalLanguage
            localModel.overview = overview
            localModel.releaseDate = releaseDate
            localModel.imageURL = imageURL?.absoluteString
            localModel.isFavorite = isFavorite
            let newGenreIDS = List<Int>()
            genreIDS?.forEach { genreId in
                newGenreIDS.append(genreId)
            }
            localModel.genreIDS = newGenreIDS
            return localModel
        }
    }
}
