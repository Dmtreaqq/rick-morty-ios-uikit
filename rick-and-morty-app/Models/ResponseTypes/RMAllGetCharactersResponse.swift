//
//  RMGetCharactersResponse.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 04.05.2024.
//

import Foundation



struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}


