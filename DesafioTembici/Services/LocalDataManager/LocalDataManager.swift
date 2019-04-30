//
//  LocalDataManager.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import RealmSwift

/// Manager that helps to percist data on device
class LocalDataManager {
    // Singleton
    static let shared: LocalDataManager = LocalDataManager()
    
    func addObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: "didSetFavorite"), object: nil)
    }
    
    func removeObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}

// MARKS - Favorite Movies
extension LocalDataManager {
    
    /// Inserts Favorite Movie on Local Database
    ///
    /// - Parameter model: Movie that will be stored
    /// - Throws: Realm error
    func setMovie(from model: MovieViewModel) throws {
        let realm = try Realm()
        try realm.write() {
            let newMovie = model.toLocalModel()
            
            if let oldMovie = realm.objects(MovieLocal.self).first(where: { $0.movieId == newMovie.movieId }) {
                realm.delete(oldMovie)
            }
            
            if newMovie.isFavorite {
                realm.add(newMovie)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSetFavorite"), object: nil)
        }
    }
    
    /// Delete Favorite movie from Local Database
    ///
    /// - Parameter model: Movie that will be removed
    /// - Throws: Realm error
    func removeMovie(from model: MovieViewModel) throws {
        let realm = try Realm()
        try realm.write() {
            if let oldMovie = realm.objects(MovieLocal.self).first(where: { $0.movieId == model.id }) {
                realm.delete(oldMovie)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSetFavorite"), object: nil)
        }
    }
    
    /// Fetch Favorite movies
    ///
    /// - Returns: Movies from Local Database
    /// - Throws: Realm error
    func getMovies() throws -> [MovieViewModel] {
        let realm = try Realm()
        let localMovies: Results<MovieLocal> = { realm.objects(MovieLocal.self) }()
        let movies: [MovieViewModel] = localMovies.filter({ $0.isFavorite }).map({ MovieViewModel(from: $0) })
        print("movies: \(movies)")
        return movies
    }
}

// MARK: - Genres
extension LocalDataManager {
    
    /// Fetch Genres
    ///
    /// - Returns: Genres from Local database
    /// - Throws: Real error
    func getGenres() throws -> [GenreViewModel] {
        let realm = try Realm()
        let localGenres: Results<GenreLocal> = { realm.objects(GenreLocal.self) }()
        let genres: [GenreViewModel] = localGenres.map({ GenreViewModel(from: $0) })
        print("genres: \(genres)")
        return genres
    }
    
    /// Inserts new Genres on Local Database
    ///
    /// - Parameter genres: Genres that will be inserted
    /// - Throws: Realm error
    func setGenres(_ genres: [GenreViewModel]) throws {
        let realm = try Realm()
        try realm.write() {
            
            let localGenres: Results<GenreLocal> = { realm.objects(GenreLocal.self) }()
            realm.delete(localGenres)
            
            genres.forEach { genre in
                let localModel = genre.toLocalModel()
                realm.add(localModel)
            }
        }
    }
}
