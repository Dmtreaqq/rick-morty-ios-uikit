//
//  RMCharacterCollectionViewCellViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import Foundation

class RMCharacterCollectionViewCellViewModel {
    let id: Int
    let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(id: Int, characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.id = id
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    var characterStatusText: String {
        return "Status: \(characterStatus.text)" 
    }
    
    func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        
        
        guard let characterImageUrl else { completion(.failure(URLError(.badURL))); return }
        let request = URLRequest(url: characterImageUrl)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
