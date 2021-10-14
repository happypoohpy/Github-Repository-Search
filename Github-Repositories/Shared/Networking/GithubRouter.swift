import Foundation

enum GithubRouter: RequestInfoConvertible {
    case repos(query: String, page: Int)
    
    var endpoint: String {
        "https://api.github.com"
    }
    
    var urlString: String {
        "\(endpoint)/\(path)"
    }
    
    var path: String {
        switch self {
        case .repos(_, _):
            return "search/repositories"
        }
    }
    
    func asRequestInfo() -> RequestInfo {
        var requestInfo: RequestInfo = RequestInfo(url: urlString)
        // Set other property, like headers, parameters for requestInfo here
        switch self {
        case .repos(let query, let page):
            requestInfo.parameters = [
            "accept" : "application/vnd.github.v3+json",
            "sort" : "star",
            "per_page": 20,
            "page": page,
            "q" : query]
        }
        
        return requestInfo
    }
}
