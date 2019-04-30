//
//  Constants+Errors.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

extension Constants {
    enum Errors: Error {
        case invalidUrlString
        case serverError(String?)
    }
}
