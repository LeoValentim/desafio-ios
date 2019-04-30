//
//  EndpointBuilder.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import Foundation


/// Class that helps to build endpoint URL
class EndpointBuilder<Controller: EndpointController, Action: EndpointAction, Param: EndpointParam> {
    weak var api: APILayer?
    
    private let controller: String
    private var action: String?
    private var params: [String : String] = [:]
    
    init(for api: APILayer, withController controller: Controller) {
        self.api = api
        self.controller = controller.value
    }
    
    init(for api: APILayer, withRecpectiveSubControllers subControllers: Set<Controller>, controller: Controller) {
        self.api = api
        self.controller = controller.value
    }
    
    /// Adds action to url
    ///
    /// - Parameter action: Action thet will be addad
    /// - Returns: Self class
    func addAction(_ action: Action) -> EndpointBuilder {
        self.action = action.value
        return self
    }
    
    /// Adds Param to url
    ///
    /// - Parameter param: Param that will be added
    /// - Returns: Self class
    func addParam(_ param: Param) -> EndpointBuilder {
        return addParam(param, withValue: "")
    }
    
    /// Adds Param and value to url
    ///
    /// - Parameters:
    ///   - param: Param Key that will be added
    ///   - value: Param Value that will be added
    /// - Returns: Self class
    func addParam(_ param: Param, withValue value: String) -> EndpointBuilder {
        params[param.value] = value
        return self
    }
}

// MARK: - Build Actions
extension EndpointBuilder {
    
    /// Build final URL
    ///
    /// - Returns: EndPoint URL
    /// - Throws: Bad URL
    func build() throws -> URL {
        var currentURLString = try generateURLString()
        insertAction(&currentURLString)
        insertParams(&currentURLString)
        return try generateURL(currentURLString)
    }
    
    // Insert Controller
    private func generateURLString() throws -> String {
        guard let baseURLString = api?.baseURLString else {
            throw Constants.Errors.invalidUrlString
        }
        return baseURLString + "/" + controller
    }
    
    // Insert Action
    private func insertAction(_ currentURLString: inout String) {
        if let action = action {
            currentURLString += "/" + action
        }
    }
    
    // Insert Params
    private func insertParams(_ currentURLString: inout String) {
        var paramCount = 0
        params.forEach { param in
            if paramCount == 0 {
                currentURLString += "?"
            } else {
                currentURLString += "&"
            }
            
            currentURLString += param.key
            
            if !param.value.isEmpty {
                currentURLString += "=" + param.value
            }
            
            paramCount += 1
        }
    }
    
    // Generate URL
    private func generateURL(_ currentURLString: String) throws -> URL {
        if let url = URL(string: currentURLString) {
            return url
        }
        throw Constants.Errors.invalidUrlString
    }
}

