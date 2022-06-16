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
        case notingToUpdateState
    }
    
    struct State {
    }
    
    func mutate(action: Action) -> Observable<Mutating> {
        switch action {
        case .loginButtonTapped:
            RequestGithubLogin().openGithubLogin()
            return Observable.just(Mutation.notingToUpdateState)
        }
    }
    
    func reduce(state: State, mutation: Mutating) -> State {
        switch mutation {
        case .notingToUpdateState:
            break
        }
        return state
    }
}
