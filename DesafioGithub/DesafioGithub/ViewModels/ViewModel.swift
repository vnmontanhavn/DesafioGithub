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

class ViewModel {
    var model: Model?
    var view: ViewController?
    var delegate: ListViewModelProtocol?
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

extension ViewModel: ListViewModelProtocol {
    func showDetails(url: String) {
        self.model?.getDetail(userURL: url)
    }
}

extension ViewModel: ModelProtocol {
    func openList(viewModel: [UserListItemViewModel]) {
        self.view?.updateUsers(users: viewModel)
    }
    
    func openDetail(viewModel: UserDetailViewModel) {
        self.view?.stopIndicatorAnimation()
        let detailView = DetailViewController()
        detailView.setupController(model: viewModel)
        DispatchQueue.main.async {
            self.view?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    func showError(message: String) {
        view?.showError(message: message)
    }
}
