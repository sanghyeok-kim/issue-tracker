//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import UIKit
import ReactorKit
import RxRelay

class SceneDelegate: UIResponder, UIWindowSceneDelegate, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    private let takeCode = PublishRelay<String>()
    
    func bind(reactor: LoginReactor) {
        takeCode
            .map { Reactor.Action.inputUserCode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    var window: UIWindow?
    
    override init() {
        super.init()
        reactor = LoginReactor()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = ViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let url = URLContexts.first?.url
        let tempCode = url?.absoluteString.components(separatedBy: "code=").last ?? ""
        takeCode.accept(tempCode)
    }
}

struct Token: Decodable {
    let access_token: String
    let scope: String
    let token_type: String
}
