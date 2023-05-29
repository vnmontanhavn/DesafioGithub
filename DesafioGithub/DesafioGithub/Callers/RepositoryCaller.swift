//
//  repositoryCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation
import Alamofire

class RepositoryCaller: CallerProtocol {
    var delegate: CallResponseDelegate?
    
    required init(delegate: CallResponseDelegate?) {
        self.delegate = delegate
    }
    
    func call(userURL: String?) {
        if let urlAddress = userURL,  let url = URL(string: urlAddress) {
            getList(url: url)
        }
    }
    
    func getList(url: URL) {
        AF.request(url).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode([RepositoryModel].self, from: value)
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
