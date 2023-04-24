import UIKit

class DogViewController: UIViewController {
    
    @IBOutlet var dogImage: UIImageView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    private let dogController = DogController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        fetchNewDog()
    }
        
    func fetchNewDog() {
        Task {
            do {
                let dog = try await dogController.fetchDog()
                let image = try await dogController.getImageData(from: dog.message)
                spinner.stopAnimating()
                dogImage.image = image
            } catch {
                print("Error fetching dog image: \(error)")
            }
        }
    }
    
    @IBAction func refreshDogs(_ sender: Any) {
        spinner.startAnimating()
        fetchNewDog()
    }
}

