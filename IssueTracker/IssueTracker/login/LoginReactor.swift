//
//  LoginReactor.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/15.
//

import Foundation
import ReactorKit

final class LoginReactor: Reactor {
    var initialState: State = State()
    
    enum Action {
        case loginButtonTapped
    }
    
    enum Mutating {
        case requestGithubLogin
    }
    
    struct State {
    }
    
    func mutate(action: Action) -> Observable<Mutating> {
        switch action {
        case .loginButtonTapped:
            let clientID = "2ca00a62da0566df46d7"
            let scope = "login"
            let urlString = "https://github.com/login/oauth/authorize"
            guard var components = URLComponents(string: urlString) else { return Observable.just(Mutation.requestGithubLogin) }
            components.queryItems = [
                URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "scope", value: scope),
            ]
            guard let url = components.url else { return Observable.just(Mutation.requestGithubLogin) }
            UIApplication.shared.open(url)
            return Observable.just(Mutation.requestGithubLogin)
        }
    }
    
    func reduce(state: State, mutation: Mutating) -> State {
        switch mutation {
        case .requestGithubLogin:
            break
        }
        return state
    }
}
