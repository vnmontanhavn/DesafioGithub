//
//  ViewModelDetail.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 30/07/23.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    func getRepository()
}

class ViewModelDetail {
    var model: Model?
    var detailModel: UserDetailViewModel?
    var view: DetailViewController?
    
    init() {
        model = Model(delegate: self)
    }
    
    func setupController(detailModel: UserDetailViewModel) -> UIViewController? {
        self.view = DetailViewController()
        self.detailModel = detailModel
        self.view?.setupController(model: detailModel)
        model?.getRepository(userURL: detailModel.repositoresURL)
        view?.startIndicatorAnimation()
        return view
    }
    
}

extension ViewModelDetail: ModelProtocol {
    func showError(message: String) {
        DispatchQueue.main.async {
            self.view?.showError(message: message)
        }
    }
    
    func updateRepository(repositorys: [RepositoryModel]) {
        view?.updateRepo(repos: repositorys)
    }
}
