//
//  IssueTrackerTests.swift
//  IssueTrackerTests
//
//  Created by 김동준 on 2022/06/13.
//

import XCTest
import Moya
import RxSwift
@testable import IssueTracker

class IssueTrackerTests: XCTestCase {
    
    var tokenExchangable: GitHubTokenExchangable!
    var reactor: SceneReactor!
    
    override func setUpWithError() throws {
        tokenExchangable = GithubRepositoryStub()
        reactor = SceneReactor(tokenProvider: tokenExchangable)
    }
    
    func testTokenExchange() throws {
        let expectation = XCTestExpectation()
        guard let json = Bundle.main.path(forResource: "MockAccessToken", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOfFile: json) else { return }
        guard let mockData = jsonString.data(using: .utf8) else { return }
        guard let expectedToken = try? JSONDecoder().decode(Token.self, from: mockData).access_token else { return }
        
        tokenExchangable.provider.rx
            .request(.exchangeToken("code"))
            .map(Token.self)
            .map { $0.access_token }
            .asObservable()
            .bind { token in
                XCTAssertEqual(expectedToken, token)
                expectation.fulfill()
            }
            .dispose()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSceneReactor() throws {
        let expectation = XCTestExpectation()
        
        reactor.action
            .onNext(.checkRootViewController)
        
        reactor.action
            .onNext(.inputUserCode("code"))
        
        reactor.state
            .map { $0.rootViewController }
            .bind { viewControllerType in
            XCTAssertEqual(true, (viewControllerType == .issue || viewControllerType == .login) )
        }
        .dispose()
        
        reactor.state
            .map { $0.hasToken }
            .bind {
                XCTAssertEqual(true, $0)
                expectation.fulfill()
            }
            .dispose()
        wait(for: [expectation], timeout: 1.0)
        
    }
}
