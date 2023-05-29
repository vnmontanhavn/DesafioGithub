//
//  UserListCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 11/05/23.
//

import Foundation
import Alamofire

class UserListCaller: CallerProtocol {
    internal var delegate: CallResponseDelegate?
    
    required init(delegate: CallResponseDelegate? = nil) {
        self.delegate = delegate
    }
    
    func call() {
        getList()
    }
    
    func getList() {
        AF.request("https://api.github.com/users").responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode([UserModel].self, from: value)
                    self.delegate?.success(response: myResponse)
                } else {
                    self.delegate?.fail(errorMessage: response.error?.localizedDescription ?? "Um erro aconteceu")
                }
            }
            catch {
                self.delegate?.fail(errorMessage: error.localizedDescription)
            }
        }
    }
}
