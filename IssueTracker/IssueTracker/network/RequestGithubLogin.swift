//
//  RequestGithubLogin.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/16.
//

import UIKit

struct RequestGithubLogin {
    func openGithubLogin() {
        let clientID = "2ca00a62da0566df46d7"
        let scope = "login"
        let urlString = "https://github.com/login/oauth/authorize"
        guard var components = URLComponents(string: urlString) else { return }
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        guard let url = components.url else { return }
        UIApplication.shared.open(url)
    }
}
