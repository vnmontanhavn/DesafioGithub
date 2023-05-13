//
//  UserDetailCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation
import Alamofire

class UserDetailCaller {
    func getDetail (userURL: String, success: @escaping (DetailModel) -> Void, fail: @escaping (String) -> Void) {
        AF.request(userURL).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode(DetailModel.self, from: value)
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
