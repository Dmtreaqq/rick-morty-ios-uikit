//
//  RMService.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 04.05.2024.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
}

/// Singleton network service for doing HTTP requests
final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    // MARK: - Read about @escaping
    
    
    /// Send API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: Type of object we expect to get from API
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
