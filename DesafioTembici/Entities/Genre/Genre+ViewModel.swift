//
//  Genre+ViewModel.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

typealias GenreViewModel = Genre.Model.ViewModel

extension Genre.Model {
    struct ViewModel {
        let id: Int?
        let name: String?
        
        init(from model: Genre) {
            id = model.id
            name = model.name
        }
        
        init(from localModel: GenreLocal) {
            id = localModel.id
            name = localModel.name
        }
        
        func toLocalModel() -> GenreLocal {
            let localModel = GenreLocal()
            localModel.id = id ?? 0
            localModel.name = name ?? ""
            return localModel
        }
    }
}
