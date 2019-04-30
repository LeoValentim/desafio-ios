//
//  MovieDetailInterector.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

// MARK: - Interector
class MovieDetailInterector {
    weak var presenter: MovieDetailsPresenterInterector?
}

// MARK: - Interector / Presenter
protocol MovieDetailInterectorPresenter: class {
    func setMovie(_ model: MovieViewModel, asFavorite value: Bool)
}
extension MovieDetailInterector: MovieDetailInterectorPresenter {
    func setMovie(_ model: MovieViewModel, asFavorite value: Bool) {
        var newModel = model
        newModel.isFavorite = value
        do {
            try LocalDataManager.shared.setMovie(from: newModel)
            presenter?.didFavoriteMovie()
        } catch {
            presenter?.didFailure(error)
        }
    }
}
