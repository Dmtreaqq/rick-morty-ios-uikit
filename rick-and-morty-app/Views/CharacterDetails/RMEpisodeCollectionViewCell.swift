//
//  RMEpisodeCollectionViewCell.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 08.05.2024.
//

import UIKit

class RMEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .magenta
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configure(with viewModel: RMEpisodeCollectionViewCellViewModel) {
        
    }
}
