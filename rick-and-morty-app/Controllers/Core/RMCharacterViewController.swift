import UIKit

// MARK: - read about String(describing:)
// MARK: - why Constraints should be after addSubview method

class RMCharacterViewController: UIViewController {
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(characterListView)
        
        characterListView.delegate = self
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RMCharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let vc = RMCharacterDetailViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
