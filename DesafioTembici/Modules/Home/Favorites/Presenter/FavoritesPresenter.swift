//
//  FavoritesPresenter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

class FavoritesPresenter  {
    weak var view: FavoritesInput?
    var interector: FavoritesInterectorPresenter?
    var router: FavoritesRouterProtocol?
    
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
        } catch {
            view?.didFailure(error)
            completion()
        }
    }
}

// MARK: - Presenter / View
protocol FavoritesOutput: class {
    var moviesCount: Int {get}
    func getMovie(at index: Int) -> MovieViewModel
    func getMovies()
    func removeMovie(at index: Int)
    
    func filterContentForSearchText(_ text: String)
    
    func goToDetailsOfMovie(at index: Int)
}
extension FavoritesPresenter: FavoritesOutput {
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
    func removeMovie(at index: Int) {
        let model: MovieViewModel
        if view?.isFiltering == true {
            model = filteredMovies[index]
        } else {
            model = movies[index]
        }
        
        interector?.removeMovie(model)
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
protocol FavoritesPresenterInterector: class {
    func didGetMovies(movies: [MovieViewModel])
    func didFailure(_ error: Error)
}
extension FavoritesPresenter: FavoritesPresenterInterector {
    func didGetMovies(movies: [MovieViewModel]) {
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
    
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
