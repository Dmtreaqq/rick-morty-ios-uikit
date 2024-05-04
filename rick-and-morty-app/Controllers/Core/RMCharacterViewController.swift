import UIKit

class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let queryParams = [URLQueryItem(name: "name", value: "Rick"), URLQueryItem(name: "status", value: "alive")]
        let request = RMRequest(endpoint: .character, queryParameters: queryParams)
        
        print(request.url!)
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            print(result)
        }
    }
}
