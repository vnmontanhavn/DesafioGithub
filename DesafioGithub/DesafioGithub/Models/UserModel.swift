//
//  UserModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 11/05/23.
//

import Foundation

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
