//
//  GithubTokenProvider.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import RxSwift

protocol GitHubTokenExchangable {
    func exchangeToken(by code: String) -> Observable<String>
}

final class GithubTokenProvider {
    
}
