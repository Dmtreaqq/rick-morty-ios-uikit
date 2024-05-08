//
//  RMInfoCollectionViewCell.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 08.05.2024.
//

import UIKit

class RMInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .systemFont(ofSize: 21, weight: .light)
        return valueLabel
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        return titleLabel
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
       let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        
        return iconImageView
    }()
    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        titleContainerView.addSubview(titleLabel)
        contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        valueLabel.text = nil
        iconImageView.image = nil
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            valueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with viewModel: RMInfoCollectionViewCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
        self.iconImageView.image = UIImage(systemName: "globe.americas")
    }
}
