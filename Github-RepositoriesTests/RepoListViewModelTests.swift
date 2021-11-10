//
//  RepoListViewModelTests.swift
//  Github-RepositoriesTests
//
//  Created by Joy Marie Navales on 11/10/21.
//

import XCTest
import Combine
@testable import Github_Repositories

class RepoListViewModelTests: XCTestCase {

    var networkClient: MockNetworkClient!
    var githubNetworkClient : GithubNetworkClient!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        networkClient = TestUtils.mockNetworkClient(file: "repos.json")
        githubNetworkClient = GithubNetworkClient()
        githubNetworkClient.networkClient = networkClient
    }
    
    override func tearDownWithError() throws {
        networkClient = nil
        githubNetworkClient = nil
        try super.tearDownWithError()
    }
    
    func testSearchReposQueryReponseHas20Items() {

        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        let exp = expectation(description: "Test after 5 seconds")
        
        viewModel.searchRepos(query: "ios")
        
        _ = XCTWaiter.wait(for: [exp], timeout: 5.0)
        
        XCTAssertEqual(viewModel.repos.count , 20)
    }
    
    func testSearchReposStartsWithPage1() {

        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        viewModel.searchRepos(query: "ios")
        
        XCTAssertEqual(viewModel.page, 1)
    }
    
    func testSearchMoreReposWithEmptyRepoListIncrementPagingAndRepoCount() {
        
        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        viewModel.searchMoreRepos(query: "ios")
        
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.repos.count, 0)
    }
    
    func testSearchMoreReposWithNotEmptyRepoListIncrementPagingAndRepoCount() throws {

        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        viewModel.repos = try JSONDecoder().decode(RepoList.self, from: networkClient.response.0!).items!
        viewModel.page = 1
        
        for i in 2...5 {
            let exp = expectation(description: "Test after 5 seconds")
            
            viewModel.searchMoreRepos(query: "ios")
            
            _ = XCTWaiter.wait(for: [exp], timeout: 5.0)
            
            XCTAssertEqual(viewModel.page, i)
            XCTAssertEqual(viewModel.repos.count, i * 20)

        }
    }
    
    func testQueryReposCallLoadingTrue() {
        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        viewModel.queryRepos(query: "ios")
        
        XCTAssertEqual(viewModel.isLoading, true)
    }
    
    func testQueryReposCompletesLoadingFalse() {
        let viewModel = RepoListViewModel()
        viewModel.networkClient = githubNetworkClient
        
        let exp = expectation(description: "Test after 5 seconds")
        
        viewModel.queryRepos(query: "ios")
        
        _ = XCTWaiter.wait(for: [exp], timeout: 5.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
    }
}
