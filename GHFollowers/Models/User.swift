//
//  User.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 08..
//

import Foundation

struct User: Codable {
    let login: String
    let avatarURL: String
    let htmlURL: String
    let name: String?
    let location: String?
    let bio: String?
    let company: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    let blog: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case name
        case bio
        case company
        case location
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
        case blog
    }
}

extension User {
    
    var dateResult: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: createdAt)
        return "\(localDate)"
    }
}
