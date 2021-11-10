//
//  GithubNetworkProviderTests.swift
//  Github-RepositoriesTests
//
//  Created by Joy Marie Navales on 11/10/21.
//

import XCTest
import Combine
@testable import Github_Repositories

class GithubNetworkProviderTests: XCTestCase {
    
    func testSearchReposCallCompletes() {
        let exp = expectation(description: "Search repo api call completes")
        var subscriptions = Set<AnyCancellable>()
        
        let networkClient = TestUtils.mockNetworkClient(file: "repos.json")
        
        let githubNetworkClient = GithubNetworkClient()
        githubNetworkClient.networkClient = networkClient
        
        githubNetworkClient.searchRepos(query: "ios", page: 1).sink { _ in } receiveValue: { result in
            
            XCTAssert(true)
            
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 10.0)
    }
    
    func testGithubNetworkClientSearchReposCallParseSuccess() {
        let exp = expectation(description: "Parse repos success")
        var subscriptions = Set<AnyCancellable>()
        
        let networkClient = TestUtils.mockNetworkClient(file: "repos.json")
        let githubNetworkClient = GithubNetworkClient()
        githubNetworkClient.networkClient = networkClient
        
        githubNetworkClient.searchRepos(query: "ios", page: 1).sink { _ in } receiveValue: { result in
            
            let firstRepo = result.items?.first
            let isCorrectParsing = firstRepo?.id != nil && firstRepo?.name != nil
            
            XCTAssert(isCorrectParsing)
            
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 10.0)
    }
}
