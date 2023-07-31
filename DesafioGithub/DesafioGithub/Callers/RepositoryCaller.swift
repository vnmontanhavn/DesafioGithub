//
//  repositoryCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation

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
    
    func dataModel(data: Data?) {
        do {
            let decoder = JSONDecoder()
            if let value = data {
                let myResponse = try decoder.decode([RepositoryModel].self, from: value)
                self.delegate?.success(response: myResponse)
            } else {
                self.delegate?.fail(errorMessage: "Um erro aconteceu durante o Parse")
            }
        }
        catch {
            self.delegate?.fail(errorMessage: error.localizedDescription)
        }
    }
    
    func getList(url: URL) {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        dataTask =
        defaultSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.fail(errorMessage:"Full Exception!!")
                return
            }
            if response.statusCode == 200 {
                self.dataModel(data: data)
            } else {
                self.delegate?.fail(errorMessage: error?.localizedDescription ?? "Um erro inesperado aconteceu, Code:\(response.statusCode)")
            }
        }
        dataTask?.resume()
    }
}
