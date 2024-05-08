//
//  RMCharacterDetailViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import Foundation

class RMCharacterDetailViewViewModel {
    let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    var title: String {
        character.name.uppercased()
    }
    
    var requestURL: URL? {
        URL(string: character.url)
    }
}
