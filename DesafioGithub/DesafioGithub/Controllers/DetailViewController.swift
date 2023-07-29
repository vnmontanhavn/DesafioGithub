//
//  DetailViewController.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    lazy var tableView = UITableView()
    private var model: UserDetailViewModel? = nil
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    var repos: [RepositoryModel] = []
    var repoCallDelegate: CallerProtocol?
    ///Métodos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoCallDelegate = RepositoryCaller(delegate: self)
        self.view.backgroundColor = .blue
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        self.setupConstraints()
        self.setupTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callRepo()
    }
    
    private func setupTableview() {
        self.tableView.register(DetailImageCell.self, forCellReuseIdentifier: DetailImageCell().getIdentifier())
        self.tableView.register(DetailInfoCell.self, forCellReuseIdentifier: DetailInfoCell().getIdentifier())
        self.tableView.register(DetailRepositoryCell.self, forCellReuseIdentifier: DetailRepositoryCell().getIdentifier())
    }
    
    func setupController(model: UserDetailViewModel){
        self.model = model
        self.title = model.userName
    }
    
    private func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.indicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        ])
        
    }
    
    func callRepo() {
        guard let model = self.model else {
            return
        }
        startIndicatorAnimation()
        
        repoCallDelegate?.call(userURL: model.repositoresURL)
    }
    func showError(message: String) {
        let errorView = ErrorViewController()
        errorView.setup(errorMessage: message)
        self.present(errorView, animated: true)
        self.stopIndicatorAnimation()
    }
    
    func startIndicatorAnimation() {
        self.indicator.startAnimating()
    }
    
    func stopIndicatorAnimation() {
        self.indicator.stopAnimating()
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = self.model else {
            return 0
        }
        if section == 0 {
            return 2
        } else {
            return self.repos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageCell().getIdentifier()) as? DetailImageCell else {
                    return UITableViewCell()
                }
                cell.setupcell(viewModel: model)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell().getIdentifier()) as? DetailInfoCell else {
                    return UITableViewCell()
                }
                cell.setupCell(model: model, linkDelegate: self)
                return cell
            }
        } else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: DetailRepositoryCell().getIdentifier()) as? DetailRepositoryCell else {
                return UITableViewCell()
            }
            cell.setupCell(titleText: repos[indexPath.row].name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return DetailImageCell().height()
            } else {
                return DetailInfoCell().height()
            }
        } else {
            return DetailRepositoryCell().height()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let url = URL(string: repos[indexPath.row].htmlUrl) {
                openLink(url: url)
            }
        }
    }
}

extension DetailViewController: LinkProtocol {
    func openLink(url: URL) {
        UIApplication.shared.open(url)
    }
}

extension DetailViewController: CallResponseDelegate {
    func success<T>(response: T) {
        if let response = response as? [RepositoryModel] {
            self.repos = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.stopIndicatorAnimation()
            }
        }
    }
    
    func fail(errorMessage: String) {
        DispatchQueue.main.async {
            self.showError(message: errorMessage)
        }
    }
    
    
}
