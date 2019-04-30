//
//  EndpointBuilderProtocols.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

protocol EndpointProtocol: Hashable, RawRepresentable {
    var value: String {get}
}

extension EndpointProtocol {
    var value: String {
        if Self.RawValue.self == String.self {
            return self.rawValue as! String
        }
        
        return "\(self.rawValue)"
    }
}

protocol EndpointController: EndpointProtocol {}
protocol EndpointAction: EndpointProtocol {}
protocol EndpointParam: EndpointProtocol {}
