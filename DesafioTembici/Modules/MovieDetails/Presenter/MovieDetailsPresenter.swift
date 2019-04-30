//
//  MovieDetailsPresenter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

class MovieDetailsPresenter {
    weak var view: MovieDetailsInput?
    var interector: MovieDetailInterectorPresenter?
    var router: MovieDetailsRouter?
}

// MARK: - Presenter / View
protocol MoviesDetailsOutput: class {
    func setFavoriteMovie(_ model: MovieViewModel)
}
extension MovieDetailsPresenter: MoviesDetailsOutput {
    func setFavoriteMovie(_ model: MovieViewModel) {
        interector?.setMovie(model, asFavorite: !model.isFavorite)
    }
}

// MARK: - Presenter / Interector
protocol MovieDetailsPresenterInterector: class {
    func didFavoriteMovie()
    func didFailure(_ error: Error)
}
extension MovieDetailsPresenter: MovieDetailsPresenterInterector {
    func didFavoriteMovie() {
        view?.didFavoriteMovie()
    }
    
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
