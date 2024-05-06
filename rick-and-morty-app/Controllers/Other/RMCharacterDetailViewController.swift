//
//  RMCharacterDetailViewController.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 06.05.2024.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewViewModel
    
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
    }
}
