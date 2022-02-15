//
//  Follower.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 08..
//

import Foundation

struct Follower: Codable, Hashable {
    
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }

}
