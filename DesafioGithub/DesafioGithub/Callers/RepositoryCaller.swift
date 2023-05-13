//
//  repositoryCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation
import Alamofire

class RepositoryCaller {
    func getList(url: URL, success: @escaping ([RepositoryModel]) -> Void, fail: @escaping (String) -> Void) {
        AF.request(url).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode([RepositoryModel].self, from: value)
                    success(myResponse)
                } else {
                    fail(response.error?.localizedDescription ?? "Um erro aconteceu")
                }
            }
            catch {
                fail(error.localizedDescription)
            }
        }
    }
}
