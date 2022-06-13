//
//  GithubTokenProvider.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import RxSwift
import Moya

protocol GitHubTokenExchangable {
    func exchangeToken(by code: String) -> Single<String>
}

final class GithubTokenService: GitHubTokenExchangable {
    let provider = MoyaProvider<GithubAPI>()
    
    func exchangeToken(by code: String) -> Single<String> {
        Single.create { [weak self] observe in
            self?.provider.request(.exchangeToken(code)) { result in
                switch result {
                case .success(let response):
                    guard let result = try? response.map(Token.self) else {
                        print("json error!! ")
                        print(String(data: response.data,encoding: .utf8)!)
                        return observe(.failure(MoyaError.jsonMapping(response)))
                    }
                    print("result \(result.access_token)")
                    observe(.success(result.access_token))
                case .failure(let error):
                    print("error!! \(error)")
                    observe(.failure(error))
                }
            }
            return Disposables.create { }
        }
    }
}
