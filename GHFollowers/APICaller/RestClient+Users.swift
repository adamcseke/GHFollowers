//
//  RestClient+Users.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 08..
//

import Foundation

extension RestClient {
    
    public func getFollowers(user: String, page: Int, completion: @escaping (Result<[Follower], Error>) -> Void) {
        let url = Constants.baseUrl + "users/\(user)" + "/followers?per_page=100&page=\(page)"
        request(urlString: url, completion: completion)
    }
    
    public func getUserInfo(user: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = Constants.baseUrl + "users/\(user)"
        request(urlString: url, completion: completion)
    }
}
