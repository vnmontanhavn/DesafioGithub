//
//  Model.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 30/07/23.
//

import Foundation

protocol ModelProtocol {
    func openList(viewModel: [UserListItemViewModel])
    func openDetail(viewModel: UserDetailViewModel)
    func updateRepository(repositorys: [RepositoryModel])
    func showError(message: String)
}
extension ModelProtocol {
    func openList(viewModel: [UserListItemViewModel]) {}
    func openDetail(viewModel: UserDetailViewModel) {}
    func updateRepository(repositorys: [RepositoryModel]) {}
}

class Model {
    var delegate: ModelProtocol?
    var listCallDelegate: CallerProtocol?
    var detailCallDelegate: CallerProtocol?
    var repoCallDelegate: CallerProtocol?
    
    init(delegate: ModelProtocol) {
        self.delegate = delegate
        repoCallDelegate = RepositoryCaller(delegate: self)
        detailCallDelegate = UserDetailCaller(delegate: self)
        listCallDelegate = UserListCaller(delegate: self)
    }
    
    func getList(){
        listCallDelegate?.call()
    }
    func getDetail(userURL: String?){
        detailCallDelegate?.call(userURL: userURL)
    }
    func getRepository(userURL: String?){
        repoCallDelegate?.call(userURL: userURL)
    }
}

extension Model: CallResponseDelegate {
    func success<T>(response: T) {
        if let response = response as? [UserModel] {
            var viewModel: [UserListItemViewModel] = []
            for model in response {
                viewModel.append(UserListItemViewModel(name: model.login, imageURL: model.avatarURL, gitURL: model.htmlURL, apiURL: model.url))
            }
            delegate?.openList(viewModel: viewModel)
        }
        
        if let response = response as? [RepositoryModel] {
            delegate?.updateRepository(repositorys: response)
        }
        
        if let response = response as? DetailModel {
            let detail = UserDetailViewModel(userName: response.login, realName: response.name ?? "unknow", imageURL: response.avatarURL ?? "", gitURL: response.url, blogURL: response.blog ?? "", twitterUsername: response.twitter ?? "", followers: response.followers, following: response.following, repositoresURL: response.repos)
            delegate?.openDetail(viewModel: detail)
        }
    }
    
    func fail(errorMessage: String) {
        delegate?.showError(message: errorMessage)
    }
    
    
}
