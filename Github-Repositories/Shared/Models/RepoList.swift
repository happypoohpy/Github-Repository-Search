import Foundation

struct RepoList: Codable {
    enum CodingKeys: String, CodingKey {
        case items, message

    }
    
    var items: [Repo]?
    var message: String?
}
