//
//  LoginReactor.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import ReactorKit
import RxSwift
import RxCocoa

final class LoginReactor: Reactor {
    var initialState: State = State()
    
    enum Action {
        case inputUserCode
    }
    
    enum Mutating {
        case requestAccessToken(String)
    }
    
    struct State {
        var accessToken: String?
    }
    
    func mutate(action: Action) -> Observable<Mutating> {
        switch action {
        case .inputUserCode:
            return 
        }
    }
    
    func reduce(state: State, mutation: Mutating) -> State {
        var newState = state
        switch mutation {
        case .requestAccessToken(let token):
            newState.accessToken = token
        return newState
    }
}
