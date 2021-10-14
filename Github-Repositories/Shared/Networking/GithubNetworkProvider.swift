import Foundation
import Combine

protocol GithubNetworkProvider {
    func searchRepos(query: String, page: Int) -> AnyPublisher<RepoList, Error>
}

class GithubNetworkClient: GithubNetworkProvider {
    var networkClient: NetworkProvider = NetworkClient.instance
    
    func searchRepos(query: String, page: Int) -> AnyPublisher<RepoList, Error> {
        networkClient.request(GithubRouter.repos(query: query, page: page)).decode()
    }
}
