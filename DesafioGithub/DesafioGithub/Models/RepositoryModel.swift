//
//  RepositoryModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation

struct RepositoryModel: Decodable {
    var name: String
    var htmlUrl: String
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case htmlUrl = "html_url"
    }
}
