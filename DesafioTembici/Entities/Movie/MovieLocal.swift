//
//  MovieLocal.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation
import RealmSwift

class MovieLocal: Object {
    @objc dynamic var movieId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var originalLanguage: String?
    @objc dynamic var overview: String?
    @objc dynamic var releaseDate: Date?
    @objc dynamic var imageURL: String?
    @objc dynamic var isFavorite: Bool = false
    dynamic var genreIDS = List<Int>()
}
