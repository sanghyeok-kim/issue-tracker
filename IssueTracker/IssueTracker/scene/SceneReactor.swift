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
    private let tokenProvider = GithubTokenRepository()
    
    enum Action {
        case checkRootViewController
        case inputUserCode(String)
    }
    
    enum Mutating {
        case updateRootViewController(ViewControllerType)
    }
    
    struct State {
        var rootViewController: ViewControllerType?
    }
    
    func mutate(action: Action) -> Observable<Mutating> {
        switch action {
        case .inputUserCode(let code):
            return tokenProvider
                .exchangeToken(by: code)
                .asObservable()
                .do { accessToken in
                    print("token \(accessToken)")
                    UserDefaultManager.shared.save(accessToken: accessToken)
                }
                .map { [weak self] _ in
                    guard let self = self else { return Mutating.updateRootViewController(.login) }
                    return Mutating.updateRootViewController(self.checkRootViewController())
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
            return newState
        }
    }
}

extension SceneReactor {
    private func checkRootViewController() -> ViewControllerType {
        (UserDefaultManager.shared.getAccessToken() == "") ? ViewControllerType.login : ViewControllerType.issue
    }
}
