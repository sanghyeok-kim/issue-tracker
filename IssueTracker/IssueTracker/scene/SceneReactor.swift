//
//  LoginReactor.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import ReactorKit
import RxSwift
import RxCocoa

final class SceneReactor: Reactor {
    var initialState: State = State()
    init (tokenProvider: GitHubTokenExchangable) {
        self.tokenProvider = tokenProvider
    }
    
    private let tokenProvider: GitHubTokenExchangable
    
    enum Action {
        case checkRootViewController
        case inputUserCode(String)
    }
    
    enum Mutating {
        case updateRootViewController(ViewControllerType)
        case updateAccessTokenState(Bool)
    }
    
    struct State {
        var rootViewController: ViewControllerType?
        var hasToken: Bool?
    }
    
    func mutate(action: Action) -> Observable<Mutating> {
        switch action {
        case .inputUserCode(let code):
            return tokenProvider
                .exchangeToken(by: code)
                .asObservable()
                .do { accessToken in
                    UserDefaultManager.shared.save(accessToken: accessToken)
                }
                .map { [weak self] _ in
                    guard let self = self else { return Mutating.updateAccessTokenState(false) }
                    return Mutating.updateAccessTokenState(!UserDefaultManager.shared.getAccessToken().isEmpty)
                }
            
        case .checkRootViewController:
            return Observable.just(checkRootViewController())
                .map { Mutating.updateRootViewController($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutating) -> State {
        var newState = state
        switch mutation {
        case .updateRootViewController(let viewControllerType):
            newState.rootViewController = viewControllerType
        case .updateAccessTokenState(let tokenResult):
            newState.hasToken = tokenResult
        }
        return newState
    }
}

extension SceneReactor {
    private func checkRootViewController() -> ViewControllerType {
        (UserDefaultManager.shared.getAccessToken().isEmpty) ? ViewControllerType.login : ViewControllerType.issue
    }
}
