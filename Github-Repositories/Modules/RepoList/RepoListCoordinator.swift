import SwiftUI

struct RepoListCoordinator : View {
    @State private var searchText: String = ""
    
    @Environment(\.openURL) var openURL
    
    @ObservedObject var viewModel = RepoListViewModel()
    
    func updateSearch(_ search: String){
        searchText = search
        viewModel.searchRepos(query: search)
    }
    
    var body: some View {
        VStack {
            SearchBar(text: Binding<String>(
                      get: {self.searchText},
                      set: {
                          self.updateSearch($0)
                      }))
            
            if !viewModel.message.isEmpty {
                Text(viewModel.message)
            }
            
            RepoListView(query: $searchText, viewModel: viewModel, tapOnRepoAction: { repo in
                if let url = repo.htmlURL {
                    openURL(url)
                }
            })
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct RepoListCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        RepoListCoordinator()
    }
}
