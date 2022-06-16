//
//  DependencyInjector.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/16.
//

import Foundation

final class DependencyInjector {
    static let shared = DependencyInjector()
    
    private lazy var tokenProvider = GithubTokenRepository()
    
    private lazy var dependencyDictionary: [ObjectIdentifier: Any] = [
        ObjectIdentifier(SceneDelegate.self): SceneDependency(manager: SceneReactor(tokenProvider: tokenProvider)),
        ObjectIdentifier(LoginViewController.self): LoginDependency(manager: LoginReactor())]
    
    func injecting<T: DependencySetable>(to compose: T){
        guard let dependency = dependencyDictionary[ObjectIdentifier(type(of: compose.self))],
              let detailedDependency = dependency as? T.DependencyType else {
                  return
              }
        compose.setDependency(dependency: detailedDependency)
    }
}

protocol DependencySetable: AnyObject {
    associatedtype DependencyType
    func setDependency(dependency: DependencyType)
    var dependency: DependencyType? { get set }
}

protocol Dependency {
    associatedtype ManagerType
}
