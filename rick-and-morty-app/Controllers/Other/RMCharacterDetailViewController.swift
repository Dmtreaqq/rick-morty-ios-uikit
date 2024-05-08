//
//  RMCharacterDetailViewController.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewViewModel
    
    private let characterDetailView = RMCharacterDetailView()
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(characterDetailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        addConstraints()
        
        
    }
    
    @objc func didTapShare() {
        // share character info
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            characterDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}
