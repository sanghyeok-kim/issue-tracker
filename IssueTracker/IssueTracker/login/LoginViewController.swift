//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import SnapKit
import RxSwift
import RxCocoa
import Then
import AuthenticationServices

class LoginViewController: UIViewController {
    
    let gitLoginButton = UIButton().then {
        $0.setTitle("Github 계정으로 로그인", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
    }
    
    let appleLoginButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(gitLoginButton)
        view.addSubview(appleLoginButton)
        
        gitLoginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
//        appleLoginButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(gitLoginButton.snp.bottom).offset(14)
//            make.width.height.equalTo(200)
//        }
        
        gitLoginButton.rx.tap.bind { _ in
            let clientID = "2ca00a62da0566df46d7"
            let scope = "login"
            let urlString = "https://github.com/login/oauth/authorize"
            guard var components = URLComponents(string: urlString) else { return }
            components.queryItems = [
                URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "scope", value: scope),
            ]
            guard let url = components.url else { return }
            UIApplication.shared.open(url)
        }
        
//        appleLoginButton.addAction(UIAction(handler: { _ in
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            
//            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//            authorizationController.delegate = self
//            authorizationController.presentationContextProvider = self
//            authorizationController.performRequests()
//        }), for: .touchUpInside)
    }
}

extension UIView {
    func addSubviews(_ views: UIView ...) {
        for view in views {
            addSubview(view)
        }
    }
}
