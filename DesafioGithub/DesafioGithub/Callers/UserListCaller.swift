//
//  UserListCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 11/05/23.
//

import Foundation
import Alamofire

class UserListCaller {
    func getList(completion: @escaping ([UserModel]) -> Void) {
        AF.request("https://api.github.com/users").responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode([UserModel].self, from: value)
                    completion(myResponse)
                }
            }
            catch {
                print("JSONSerialization error:", error)
            }
        }
    }
}
