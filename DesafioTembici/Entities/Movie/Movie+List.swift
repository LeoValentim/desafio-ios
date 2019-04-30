//
//  Movie+List.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

extension Movie.Model.UseCases.List {
    struct Request {}
    
    struct Response: Codable {
        let page: Int?
        let totalResults: Int?
        let totalPages: Int?
        let results: [Movie]?
        
        enum CodingKeys: String, CodingKey {
            case page = "page"
            case totalResults = "total_results"
            case totalPages = "total_pages"
            case results
        }
    }
}
