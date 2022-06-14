//
//  UsuerDefaultManager.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/14.
//

import Foundation

final class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    func save(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }
    
    func getAccessToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else { return "" }
        return token
    }
}
