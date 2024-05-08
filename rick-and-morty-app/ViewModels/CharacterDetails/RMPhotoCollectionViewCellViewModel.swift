//
//  RMPhotoCollectionViewCellViewModel.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 08.05.2024.
//

import Foundation

struct RMPhotoCollectionViewCellViewModel {
    let imageUrl: URL?
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        RMImageManager.shared.downloadImage(imageUrl, completion: completion)
    }
}
