//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/14.
//

import UIKit

final class IssueViewController: UIViewController {
    
    let issueCoordinate: IssueCoordinator
    
    init(issueCoordinate: IssueCoordinator) {
        self.issueCoordinate = issueCoordinate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
