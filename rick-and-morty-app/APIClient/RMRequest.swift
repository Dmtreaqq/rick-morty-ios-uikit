//
//  RMRequest.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 04.05.2024.
//

import Foundation


/// Single API call
final class RMRequest {
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    public let httpMethod = "GET"
    
    /// Constructed url for the api request
    private var urlString: String {
        var str = Constants.baseUrl
        str += "/"
        str += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                str += "/\($0)"
            }
        }
        
        if !queryParameters.isEmpty {
            str += "?"
            let argumentStr = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            str += argumentStr
        }
        
        return str
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let stringUrl = url.absoluteString
        // WHY WE NEED THIS ANYWAY???
        if !stringUrl.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = stringUrl.replacingOccurrences(of: Constants.baseUrl + "/", with: "")

        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    guard let queryParams = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems else {
                        return nil
                    }
                    
                    self.init(endpoint: rmEndpoint, queryParameters: queryParams)
                    return
                }
            }
        }
        
        
        return nil
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
