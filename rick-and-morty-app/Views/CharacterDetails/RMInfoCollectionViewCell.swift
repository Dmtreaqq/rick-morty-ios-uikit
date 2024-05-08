//
//  RMInfoCollectionViewCell.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 08.05.2024.
//

import UIKit

class RMInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMInfoCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemTeal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configure(with viewModel: RMInfoCollectionViewCellViewModel) {
        
    }
}
