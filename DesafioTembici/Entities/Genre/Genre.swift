//
//  Genre.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

extension Genre {
    enum Model {
        // MARK: Use cases
        enum UseCases {
            enum List{}
        }
    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
