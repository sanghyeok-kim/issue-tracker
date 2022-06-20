//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import ReactorKit

final class LoginViewController: UIViewController, View, DependencySetable {
    var dependency: LoginDependency? {
        didSet {
            self.reactor = dependency?.manager
        }
    }
    
    typealias DependencyType = LoginDependency
    
    private lazy var loginView = LoginView(frame: view.frame)
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        DependencyInjector.shared.injecting(to: self)
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

struct LoginDependency: Dependency {
    typealias ManagerType = LoginReactor
    let manager: ManagerType
}
