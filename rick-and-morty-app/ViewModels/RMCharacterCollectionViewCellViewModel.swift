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
        
        RMImageManager.shared.downloadImage(characterImageUrl, completion: completion)
    }
}
