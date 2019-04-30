//
//  String+extensions.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

extension String {
    func toDate(withFormat format: String, timeZone: TimeZone? = .current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: self)
    }
}
