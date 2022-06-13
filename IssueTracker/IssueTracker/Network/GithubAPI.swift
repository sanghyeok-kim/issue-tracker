//
//  GithubAPI.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/13.
//

import Moya

enum GithubAPI {
    case exchangeToken(String)
    private var clientID: String {
        return "2ca00a62da0566df46d7"
    }
    private var clientSecret: String {
        return "bf9ac50f855cabc69474299b177fa9e5082bdf07"
    }
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    
    var path: String {
        switch self {
        case .exchangeToken(_):
            return "/login/oauth/access_token"
        }
    }
    
    var method: Method {
        switch self {
        case .exchangeToken(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .exchangeToken(let code):
            let params: [String: Any] = [
                "client_id": clientID,
                "client_secret": clientSecret,
                "code": code
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .exchangeToken(_):
            return Data(
                   """
                   {
                   "access_token" : "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",
                   "token_type" : "bearer",
                   "scope" : ""
                   }
                   """.utf8
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .exchangeToken(_):
            var header = ["Content-Type": "application/json"]
            header["Accept"] = "application/json"
            return header
        }
    }
}
