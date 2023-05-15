//
//  UserListCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 11/05/23.
//

import Foundation
import Alamofire

protocol CallResponseDelegate {
    func success<T>(response: T)
    func fail(errorMessage: String)
}

protocol CallerProtocol {
    init(delegate: CallResponseDelegate?)
    var delegate: CallResponseDelegate? {get set}
    func call(userURL: String?)
    func call()
}

extension CallerProtocol {
    func call(userURL: String?) {
        //
    }
    func call() {
        //
    }
}

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
