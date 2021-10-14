import Foundation
import Combine

class RepoListViewModel: ObservableObject {
    @Published var repos: [Repo] = []
    @Published var message: String = ""
    @Published var isLoading = false
    var networkClient: GithubNetworkProvider = GithubNetworkClient()
    var page = 1;
    
    var cancellable : AnyCancellable?
    
    func searchRepos(query: String) {
        page = 1;
        repos.removeAll()
        queryRepos(query: query)
    }
    
    func searchMoreRepos(query: String) {
        if repos.isEmpty || repos.count % 20 != 0 {
            return
        }
        page += 1;
        queryRepos(query: query)
    }
    
    func queryRepos(query: String) {
        cancellable?.cancel()
        self.isLoading = true
        cancellable = networkClient
            .searchRepos(query: query, page: page)
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                case .finished: (
                    DispatchQueue.main.async {
                        self.isLoading = false
                    })
                }
            }) { reposList in
                print(reposList)
                DispatchQueue.main.async {
                    self.message = reposList.message ?? ""
                    self.repos.append(contentsOf: reposList.items ?? [])
                }
            }
    }
}
