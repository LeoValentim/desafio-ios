//
//  Constants+API.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

extension Constants.API {
    enum themoviedb: String {
        enum URL: String {
            case baseURL = "https://api.themoviedb.org/3"
            case imageURL = "https://image.tmdb.org/t/p/w500"
        }
        
        case key = "a686fe7004f7c9c3214a83eb31beb1e2"
    }
}
