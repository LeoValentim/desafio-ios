//
//  NetworkLayer.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    typealias NetworkResult<T> = Result<T, Error>
    
    func get(_ url: URL, headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void)
    func get<T: Codable>(_ url: URL, model: T.Type, headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void)
    
    func post(_ url: URL, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void)
    func post<T: Codable>(_ url: URL, model: T.Type, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void)
}
