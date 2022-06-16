//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import UIKit
import ReactorKit
import RxRelay

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, View {
    var disposeBag: DisposeBag = DisposeBag()
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let sceneInit = PublishRelay<Void>()
    private let takeCode = PublishRelay<String>()
    
    private var rootViewController: UIViewController?
    
    func bind(reactor: SceneReactor) {
        sceneInit
            .map { Reactor.Action.checkRootViewController }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        takeCode
            .map { Reactor.Action.inputUserCode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.rootViewController }
            .compactMap { $0 }
            .bind { [weak self] viewControllerType in
                guard let self = self else { return }
                let viewController = self.setRootViewController(viewController: viewControllerType)
                if self.rootViewController != nil {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
                self.rootViewController = viewController
            }
            .disposed(by: disposeBag)
    }
    
    var window: UIWindow?
    
    override init() {
        super.init()
        self.reactor = SceneReactor(tokenProvider: GithubTokenRepository())
        sceneInit.accept(())
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            //window.rootViewController = rootViewController
            window.rootViewController = LoginViewController(reactor: LoginReactor())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let url = URLContexts.first?.url
        let code = url?.absoluteString.components(separatedBy: "code=").last ?? ""
        takeCode.accept(code)
    }
}
extension SceneDelegate {
    private func setRootViewController(viewController: ViewControllerType) -> UIViewController {
        switch viewController {
        case .login:
            return LoginViewController(reactor: LoginReactor())
        case .issue:
            return IssueViewController()
        }
    }
}

struct SceneDependency: Dependency {
    typealias ManagerType = SceneReactor
    let manager: ManagerType
}

