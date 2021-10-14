import Foundation

struct Repo: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, name, description, fork, source
        case fullName = "full_name"
        case htmlURL = "html_url"
    }
    
    var id: Int?
    var name: String?
    var fullName: String?
    var description: String?
    var htmlURL: URL?
    var fork: Bool?
    var source: Container<Repo>?
}
