//
//  DetailModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
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
   "site_admin": false,
   "name": "Tom Preston-Werner",
   "company": "@chatterbugapp, @redwoodjs, @preston-werner-ventures ",
   "blog": "http://tom.preston-werner.com",
   "location": "San Francisco",
   "email": null,
   "hireable": null,
   "bio": null,
   "twitter_username": "mojombo",
   "public_repos": 64,
   "public_gists": 62,
   "followers": 23474,
   "following": 11,
   "created_at": "2007-10-20T05:24:19Z",
   "updated_at": "2023-03-22T15:06:06Z"
 }
 */

struct DetailModel: Decodable {
    var login: String
    var avatarURL: String
    var name: String
    var url: String
    var blog: String
    var twitter: String
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
