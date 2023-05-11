//
//  UserModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 11/05/23.
//

import Foundation

/*
 {
   "login": "mojombo",
   "id": 1,
   "node_id": "MDQ6VXNlcjE=",
   "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/mojombo",
   "html_url": "https://github.com/mojombo",
   "followers_url": "https://api.github.com/users/mojombo/followers",
   "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
   "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
   "organizations_url": "https://api.github.com/users/mojombo/orgs",
   "repos_url": "https://api.github.com/users/mojombo/repos",
   "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
   "received_events_url": "https://api.github.com/users/mojombo/received_events",
   "type": "User",
   "site_admin": false
 },
 */



struct UserModel: Decodable {
    var login: String
    var id: Int
    var url: String
    var htmlURL: String
    var reposURL: String
    var avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case url = "url"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case reposURL = "repos_url"
    }
}
