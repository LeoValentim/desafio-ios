//
//  NetworkLayerAlamofire.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Alamofire

/// Alamofira class that conforms to Network layer protocol
class NetworkLayerAlamofire: NetworkLayer {
    
    /// GET Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - headers: Http Header
    ///   - completion: Result Data
    func get(_ url: URL, headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void) {
        request(url, method: .get, headers: headers).response { response in
            self.logResponse(response)
            if let error = response.error {
                completion(.failure(error))
            }
            
            guard let data = response.data else {
                completion(.failure(Constants.Errors.serverError(nil)))
                return
            }
            
            completion(.success(data))
        }
    }
    
    /// GET Request that returns codable generics type
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - model: Type that will be decoded
    ///   - headers: Http Header
    ///   - completion: Result Data
    func get<T>(_ url: URL, model: T.Type, headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void) where T: Codable {
        get(url, headers: headers, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    completion(.success(resultObjc))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        })
    }
    
    /// POST Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - params: Http body
    ///   - headers: Http Header
    ///   - completion: Result Data
    func post(_ url: URL, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void) {
        request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
            self.logResponse(response)
            if let error = response.error {
                completion(.failure(error))
            }
            
            guard let data = response.data else {
                completion(.failure(Constants.Errors.serverError(nil)))
                return
            }
            
            completion(.success(data))
        }
    }
    
    /// POST Request that returns Data
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - model: Type that will be decoded
    ///   - params: Http body
    ///   - headers: Http Header
    ///   - completion: Result Data
    func post<T: Codable>(_ url: URL, model: T.Type, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void) {
        post(url, params: params, headers: headers, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    completion(.success(resultObjc))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        })
    }
    
    private func logResponse(_ response: (Alamofire.DefaultDataResponse)) {
        print("<+==== Request (\(response.request?.url?.absoluteString ?? "")) ====+>")
        print("method: \(String(describing: response.request?.httpMethod))")
        print("headers: \(String(describing: response.request?.allHTTPHeaderFields))")
        if let data = response.request?.httpBody, let dataString = String(data: data, encoding: .utf8) {
            print("requestBody: \(dataString)")
        }
        print("<+==== Response ====+>")
        print("statusCode: \(response.response?.statusCode ?? 0)")
        if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
            print("responseBody: \(dataString)")
        }
        print("<+==== End ====+>")
    }
}
