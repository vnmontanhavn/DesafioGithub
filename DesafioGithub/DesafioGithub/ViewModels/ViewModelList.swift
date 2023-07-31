//
//  ViewModel.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 30/07/23.
//

import Foundation
import UIKit

protocol ListViewModelProtocol {
    func showDetails(url: String)
}

class ViewModelList {
    var model: Model?
    var view: ViewController?
    init() {
        model = Model(delegate: self)
    }
    
    func setupController() -> UIViewController? {
        view = ViewController()
        view?.setup(delegate: self)
        model?.getList()
        return view
    }
}

extension ViewModelList: ListViewModelProtocol {
    func showDetails(url: String) {
        self.model?.getDetail(userURL: url)
    }
}

extension ViewModelList: ModelProtocol {
    func openList(viewModel: [UserListItemViewModel]) {
        self.view?.updateUsers(users: viewModel)
    }
    
    func openDetail(viewModel: UserDetailViewModel) {
        let model = ViewModelDetail()
        guard let detailView = model.setupController(detailModel: viewModel) else {
            return
        }
        DispatchQueue.main.async {
            self.view?.stopIndicatorAnimation()
            self.view?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    func showError(message: String) {
        view?.showError(message: message)
    }
}
