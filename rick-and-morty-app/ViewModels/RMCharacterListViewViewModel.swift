//
//  CharacterListViewViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 05.05.2024.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

// MARK: - Read about NSObject and that extension here
class RMCharacterListViewViewModel: NSObject {
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let name = character.name
                let status = character.status
                let url = character.image
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: name, characterStatus: status, characterImageUrl: URL(string: url))
                characterCellViewModels.append(viewModel)
            }
        }
    }
    
    private var characterCellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
//                let info = responseModel.info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = characterCellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        
        return CGSize(width: width, height: width * 1.5)
    }
}
