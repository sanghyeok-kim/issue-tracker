//
//  IssueCoordinator.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/17.
//

import Foundation
import UIKit

final class IssueCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
