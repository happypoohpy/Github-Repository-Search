import SwiftUI

struct RepoListView: View {
    @Binding var query: String
    @ObservedObject var viewModel : RepoListViewModel
    let tapOnRepoAction: (Repo) -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.repos.indices, id: \.self) { index in
                        Button(action: {
                            tapOnRepoAction(viewModel.repos[index])
                        }, label: {
                            RepoCell(repo: viewModel.repos[index])
                        })
                        Divider()
                            .onAppear {
                                if index == viewModel.repos.count - 1 {
                                    self.viewModel.searchMoreRepos(query: query)
                                }
                            }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(query: Binding.constant(""), viewModel: RepoListViewModel(), tapOnRepoAction: { repo -> Void in
            
        })
    }
}
