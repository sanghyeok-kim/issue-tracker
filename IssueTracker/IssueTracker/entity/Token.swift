//
//  Token.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/16.
//

import Foundation

struct Token: Decodable {
    let access_token: String
    let scope: String
    let token_type: String
}
