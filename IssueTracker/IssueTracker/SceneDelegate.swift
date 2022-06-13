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
//        let clientID = "2ca00a62da0566df46d7"
//        let clientSecret = "bf9ac50f855cabc69474299b177fa9e5082bdf07"
//        let urlString = "https://github.com/login/oauth/access_token"
//
//        guard var components = URLComponents(string: urlString) else { return }
//        components.queryItems = [
//            URLQueryItem(name: "client_id", value: clientID),
//            URLQueryItem(name: "client_secret", value: clientSecret),
//            URLQueryItem(name: "code", value: tempCode)
//        ]
//
//        guard let url = components.url else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: request) { data, response, error in
//            print(String(data: data!, encoding: .utf8)!)
//        }.resume()
        
    }
}
