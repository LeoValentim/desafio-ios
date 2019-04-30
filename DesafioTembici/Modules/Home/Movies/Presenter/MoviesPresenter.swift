//
//  MoviesPresenter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

// MARK: - Presenter
class MoviesPresenter {
    weak var view: MoviesInput?
    var interector: MoviesInterectorPresenter?
    var router: MoviesRouterProtocol?
    
    var genres: [GenreViewModel] = []
    var movies: [MovieViewModel] = []
    var filteredMovies: [MovieViewModel] = []
    
    func fetchGenres(completion: @escaping () -> Void) {
        do {
            let localGenres = try interector?.getLocalGenres() ?? []
            if !localGenres.isEmpty {
                genres = localGenres
                completion()
                return
            }
            
            interector?.getRemoteGenres { remoteGenres in
                self.interector?.setLocalGenres(remoteGenres)
                self.genres = remoteGenres
                completion()
            }
        } catch {
            view?.didFailure(error)
            completion()
        }
    }
}

// MARK: - Presenter / View
protocol MoviesOutput: class {
    var moviesCount: Int {get}
    func getMovie(at index: Int) -> MovieViewModel
    func getMovies()
    func setFavoriteMovie(at index: Int)
    
    func filterContentForSearchText(_ text: String)
    
    func goToDetailsOfMovie(at index: Int)
}
extension MoviesPresenter: MoviesOutput {
    var moviesCount: Int {
        if view?.isFiltering == true {
            return filteredMovies.count
        }
        return movies.count
    }
    func getMovie(at index: Int) -> MovieViewModel {
        if view?.isFiltering == true {
            return filteredMovies[index]
        }
        return movies[index]
    }
    func getMovies() {
        if genres.isEmpty {
            fetchGenres {
                self.interector?.getMovies()
            }
        } else {
            interector?.getMovies()
        }
    }
    func setFavoriteMovie(at index: Int) {
        let model: MovieViewModel
        if view?.isFiltering == true {
            model = filteredMovies[index]
        } else {
            model = movies[index]
        }
        
        interector?.setMovie(model, asFavorite: !model.isFavorite)
    }
    
    func filterContentForSearchText(_ text: String) {
        filteredMovies = movies.filter( { (movie: MovieViewModel) -> Bool in
            return movie.title.uppercased().contains(text.uppercased())
        })
        
        view?.didFilter()
    }
    
    func goToDetailsOfMovie(at index: Int) {
        let model: MovieViewModel
        if view?.isFiltering == true {
            model = filteredMovies[index]
        } else {
            model = movies[index]
        }
        
        router?.navigateToDetails(of: model)
    }
}

// MARK: - Presenter / Interector
protocol MoviesPresenterInterector: class {
    func didRequestMovies(movies: [MovieViewModel])
    func didFavoriteMovie()
    func didFailure(_ error: Error)
}
extension MoviesPresenter: MoviesPresenterInterector {
    func didRequestMovies(movies: [MovieViewModel]) {
        self.movies = []
        movies.forEach { movie in
            var newMovie = movie
            newMovie.genreIDS?.forEach { genreId in
                if !newMovie.genres.contains(where: { $0.id == genreId }),
                    let genre = genres.first(where: { $0.id == genreId }) {
                    newMovie.genres.append(genre)
                }
            }
            self.movies.append(newMovie)
        }
        view?.didGetMovies()
    }
    
    func didFavoriteMovie() {
        view?.didFavoriteMovie()
    }
    
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
