//
//  CharacterListViewViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 05.05.2024.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(character: RMCharacter)
}

// MARK: - Read about NSObject and that extension here
class RMCharacterListViewViewModel: NSObject {
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
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
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    // MARK: - Read why we need self?
    
    /// Fetch initial set of characters (20)
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    var shouldShowLoadMoreIndicator: Bool {
        apiInfo?.next != nil
    }
    
    /// Paginate if additional characters are needed
    func fetchAdditionalCharacters() {
        isLoadingMoreCharacters = true
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        
        delegate?.didSelectCharacter(character: character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupprted")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingReusableView.identifier, for: indexPath) as? RMFooterLoadingReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
                
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if !shouldShowLoadMoreIndicator {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

// MARK: - ScrollView

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        let diff = totalContentHeight - totalScrollViewFixedHeight - 120

        
        if diff > 0 && offset >= diff {
            fetchAdditionalCharacters()
            
        }
    }
}
