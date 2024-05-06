//
//  RMCharacterDetailViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import Foundation

class RMCharacterDetailViewViewModel {
    let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    var title: String {
        character.name.uppercased()
    }
}
