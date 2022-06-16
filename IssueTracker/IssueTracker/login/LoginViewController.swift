//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import ReactorKit
import RxAppState

final class LoginViewController: UIViewController, View {
    private lazy var loginView = LoginView(frame: view.frame)
    var disposeBag: DisposeBag = DisposeBag()
    
    init(reactor: LoginReactor?) {
        super.init(nibName: nil, bundle: nil)
        guard let reactor = reactor else { return }
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(reactor: LoginReactor) {
        view = loginView

        loginView.githubLoginButton.rx
            .tap
            .map { Reactor.Action.loginButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
