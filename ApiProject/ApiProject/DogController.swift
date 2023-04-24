import Foundation
import UIKit

class DogController {
    
    enum DogError: Error {
        case imageParsing
    }
    
    func fetchDog() async throws -> Dog {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Dog.self, from: data)
    }
    
    func getImageData(from url: URL) async throws -> UIImage {
        let data = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data.0) else {
            throw DogError.imageParsing
        }
        return image
    }
}
