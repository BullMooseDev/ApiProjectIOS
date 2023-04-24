import Foundation

struct RepResults: Codable {
    var results: [Representative]
}

struct Representative: Codable {
    var name: String
    var party: String
    var state: String
    var district: String
    var phone: String
    var office: String
    var link: String
   }
