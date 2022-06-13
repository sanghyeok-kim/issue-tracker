//
//  ViewController.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        button.backgroundColor = .blue
        
        button.rx.tap.bind { _ in
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
        
    }
}
extension UIView {
    func addSubviews(_ views: UIView ...) {
        for view in views {
            addSubview(view)
        }
    }
}
