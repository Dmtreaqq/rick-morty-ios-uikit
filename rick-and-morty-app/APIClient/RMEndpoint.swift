//
//  RMEndpoint.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 04.05.2024.
//

import Foundation

// MARK: - Read about @frozen, and enum without rawValue but String as type


/// List of possible used endpoints
@frozen enum RMEndpoint: String {
    // case character
    case character = "character"
    case location = "location"
    case episode = "episode"
}
