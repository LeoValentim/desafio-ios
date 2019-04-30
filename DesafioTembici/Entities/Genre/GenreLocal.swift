//
//  GenreLocal.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation
import RealmSwift

class GenreLocal: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
