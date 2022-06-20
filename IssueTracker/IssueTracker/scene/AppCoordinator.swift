//
//  AppCoordinator.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/17.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    let presentViewController: ViewControllerType
    
    init(navigationController: UINavigationController, presentViewController: ViewControllerType) {
        self.navigationController = navigationController
        self.presentViewController = presentViewController
    }
    
    func start() {
        var viewController: UIViewController
        switch presentViewController {
        case .login:
            viewController = LoginViewController()
        case .issue:
            viewController = makeTabBarController()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeTabBarController() -> UITabBarController {
        guard let navigationController = navigationController else { return UITabBarController() }
        let tabBarController = UITabBarController()
        
        let issueCordinator = IssueCoordinator(navigationController: navigationController)
        childCoordinators.append(issueCordinator)
        let issueViewController = IssueViewController(issueCoordinate: issueCordinator)
        issueViewController.tabBarItem.title = "이슈"
        issueViewController.tabBarItem.image = UIImage(systemName: "pencil")
        
        let labelViewController = UIViewController()
        labelViewController.tabBarItem.title = "레이블"
        labelViewController.tabBarItem.image = UIImage(systemName: "pencil")
        
        let milestoneViewController = UIViewController()
        milestoneViewController.tabBarItem.title = "마일스톤"
        milestoneViewController.tabBarItem.image = UIImage(systemName: "pencil")
        
        let accountViewController = UIViewController()
        accountViewController.tabBarItem.title = "내 계정"
        accountViewController.tabBarItem.image = UIImage(systemName: "pencil")
        
        tabBarController.viewControllers = [
            issueViewController, labelViewController, milestoneViewController, accountViewController
        ]
        return tabBarController
    }
}
