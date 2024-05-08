//
//  RMCharacterCollectionViewCell.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import UIKit

// MARK: - Read about frame and bounds

/// Single cell for a Character
class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
        self.setUpLayer()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (_: Self, _: UITraitCollection) in
            self?.setUpLayer()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // DEPRECATED. IF DEPLOYMENT TARGET < 17.0, than we can use this one
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        setUpLayer()
//    }
    
    
    /// Set up a layer with rounded corners and shadows
    func setUpLayer() {
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 4
        // It is done for that "masksToBounds" doesn't clip the shadow!
        contentView.layer.masksToBounds = false
    
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentView.layer.shadowOpacity = 0.3
        
        imageView.frame = contentView.bounds
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        statusLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - Read about memory leaks and retain cycles, weak self
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                /// When dealing with the UI updates, changes should be done on main thread
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print("configureError: " + String(describing: error))
                break
            }
        }
    }
}
