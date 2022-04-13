//
//  GithubResponse.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/8.
//

import Foundation

struct GithubResponse: Codable {
    let login: String // UserAccountName
    let avatar_url: String // Head Image
    let url: String // Peronal api url
}

struct PersonalResponse: Codable {
    let avatar_url: String? // Head Image
    let name: String? // User Name
    let login: String? // Account
    let location: String?
    let blog: String? // WebSite
    let updated_at: String? // updateTime
}
