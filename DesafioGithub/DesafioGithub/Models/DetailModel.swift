//
//  DetailModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation

struct DetailModel: Decodable {
    var login: String
    var avatarURL: String?
    var name: String?
    var url: String
    var blog: String?
    var twitter: String?
    var repos: String
    var followers: Int
    var following: Int
    
    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case name = "name"
        case url = "html_url"
        case blog = "blog"
        case twitter = "twitter_username"
        case repos = "repos_url"
        case followers = "followers"
        case following = "following"
    }
    
}
