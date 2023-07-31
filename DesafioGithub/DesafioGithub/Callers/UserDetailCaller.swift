//
//  UserDetailCaller.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import Foundation

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
    
    func dataModel(data: Data?) {
        do {
            let decoder = JSONDecoder()
            if let value = data {
                let myResponse = try decoder.decode(DetailModel.self, from: value)
                self.delegate?.success(response: myResponse)
            } else {
                self.delegate?.fail(errorMessage: "Um erro aconteceu durante o Parse")
            }
        }
        catch {
            self.delegate?.fail(errorMessage: error.localizedDescription)
        }
    }
    
    func getDetail(userURL: String) {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        guard let urlComponents = URLComponents(string: userURL), let url = urlComponents.url else {
            return
        }
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
