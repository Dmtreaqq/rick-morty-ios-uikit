//
//  RMCharacterCollectionViewCellViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import Foundation

class RMCharacterCollectionViewCellViewModel {
    let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    var characterStatusText: String {
        return characterStatus.rawValue
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
