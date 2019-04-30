//
//  FavoritesInterector.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

class FavoritesInterector {
    weak var presenter: FavoritesPresenterInterector?
}

// MARK: - Interector / Presenter
protocol FavoritesInterectorPresenter: class {
    func getLocalGenres() throws -> [GenreViewModel]
    func getMovies()
    func removeMovie(_ model: MovieViewModel)
}
extension FavoritesInterector: FavoritesInterectorPresenter {
    func getLocalGenres() throws -> [GenreViewModel] {
        let genres = try LocalDataManager.shared.getGenres()
        return genres
    }
    
    func getMovies() {
        do {
            let movies = try LocalDataManager.shared.getMovies()
            presenter?.didGetMovies(movies: movies)
        } catch {
            presenter?.didFailure(error)
        }
    }
    
    func removeMovie(_ model: MovieViewModel) {
        do {
            try LocalDataManager.shared.removeMovie(from: model)
        } catch {
            presenter?.didFailure(error)
        }
    }
}
