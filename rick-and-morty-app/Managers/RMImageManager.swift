//
//  ImageManager.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 07.05.2024.
//

import Foundation

class RMImageManager {
    static let shared = RMImageManager()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = imageDataCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(data as Data))
            
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        
        task.resume()
    }
}
