//
//  RMCharacterDetailViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import UIKit

class RMCharacterDetailViewViewModel {
    let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: RMPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModels: [
                .init(value: character.status.text, title: "Status"),
                .init(value: character.gender.rawValue, title: "Gender"),
                .init(value: character.type, title: "Type"),
                .init(value: character.species, title: "Species"),
                .init(value: character.origin.name, title: "Origin"),
                .init(value: character.location.name, title: "Location"),
                .init(value: character.created, title: "Created"),
                .init(value: String(character.episode.count), title: "Total Episodes"),
            ]),
            .episodes(viewModels: character.episode.map { episodeUrlText in
                return RMEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: episodeUrlText))
            })
        ]
    }
    
    func create() {
        
    }
    
    var title: String {
        character.name.uppercased()
    }
    
    var requestURL: URL? {
        URL(string: character.url)
    }
    
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

}
