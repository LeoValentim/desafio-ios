//
//  MoviesInterector.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

// MARK: - Interector
class MoviesInterector {
    weak var presenter: MoviesPresenterInterector?
    let apiLayer = TheMoviesAPILayer()
}

// MARK: - Interector / Presenter
protocol MoviesInterectorPresenter: class {
    func setLocalGenres(_ genres: [GenreViewModel])
    func getLocalGenres() throws -> [GenreViewModel]
    func getRemoteGenres(completion: @escaping ([GenreViewModel]) -> Void)
    func getMovies()
    func setMovie(_ model: MovieViewModel, asFavorite value: Bool)
}
extension MoviesInterector: MoviesInterectorPresenter {
    func setLocalGenres(_ genres: [GenreViewModel]) {
        do {
            try LocalDataManager.shared.setGenres(genres)
        } catch {
            presenter?.didFailure(error)
        }
    }
    
    func getLocalGenres() throws -> [GenreViewModel] {
        let genres = try LocalDataManager.shared.getGenres()
        return genres
    }
    
    func getRemoteGenres(completion: @escaping ([GenreViewModel]) -> Void) {
        apiLayer.getGenres { [weak self] result in
            switch result {
            case .success(let genreResult):
                let genres = genreResult.genres?.map({ GenreViewModel(from: $0) }) ?? []
                completion(genres)
            case .failure(let error):
                completion([])
                self?.presenter?.didFailure(error)
            }
        }
    }
    
    func getMovies() {
        apiLayer.getMovies { [weak self] result in
            switch result {
            case .success(let moviesResult):
                var movies = moviesResult.results?.map({ MovieViewModel(from: $0) }) ?? []
                if let localMovies = try? LocalDataManager.shared.getMovies() {
                    localMovies.forEach { localMovie in
                        if let index = movies.firstIndex(where: { $0.id == localMovie.id }) {
                            movies[index].isFavorite = localMovie.isFavorite
                        }
                    }
                }
                
                self?.presenter?.didRequestMovies(movies: movies)
            case .failure(let error):
                self?.presenter?.didFailure(error)
            }
        }
    }
    
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
