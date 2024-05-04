//
//  RMService.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 04.05.2024.
//

import Foundation

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
        completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
