//
//  Genre+List.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

extension Genre.Model.UseCases.List {
    struct Request {}
    
    struct Response: Codable {
        let genres: [Genre]?
        
        enum CodingKeys: String, CodingKey {
            case genres = "genres"
        }
    }
}
