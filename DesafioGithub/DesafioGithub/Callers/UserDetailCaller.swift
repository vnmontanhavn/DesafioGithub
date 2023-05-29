//
//  UserDetailCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation
import Alamofire

class UserDetailCaller: CallerProtocol {
    internal var delegate: CallResponseDelegate?
    
    required init(delegate: CallResponseDelegate? = nil) {
        self.delegate = delegate
    }
    
    func call(userURL: String?) {
        if let url = userURL {
            getDetail(userURL: url)
        }
    }
    
    func getDetail (userURL: String) {
        AF.request(userURL).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode(DetailModel.self, from: value)
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
