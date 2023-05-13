//
//  ViewController.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView()
    var users: [UserModel] = []
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        title = "Usuarios"
        setupTableView()
        setupActivityIndicator()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startIndicatorAnimation()
        UserListCaller().getList { response in
            self.users = response
            self.tableView.reloadData()
            self.stopIndicatorAnimation()
        } fail: { errorString in
            self.showError(message: errorString)
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UserListCell.self, forCellReuseIdentifier: UserListCell().getIdentifier())
        self.view.addSubview(self.tableView)
    }
    
    func setupActivityIndicator() {
        self.view.addSubview(self.indicator)
        indicator.hidesWhenStopped = true
    }
    
    func startIndicatorAnimation() {
        self.indicator.startAnimating()
        self.tableView.isUserInteractionEnabled = false
    }
    
    func stopIndicatorAnimation() {
        self.indicator.stopAnimating()
        self.tableView.isUserInteractionEnabled = true
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.indicator.leftAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.indicator.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
            ])
    }
    
    func showError(message: String) {
        let errorView = ErrorViewController()
        errorView.setup(errorMessage: message)
        self.present(errorView, animated: true)
        self.stopIndicatorAnimation()
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell().getIdentifier()) as? UserListCell else {
            return UITableViewCell()
        }
        if users.count <= indexPath.row {
            return UITableViewCell()
        }
        let  model = users[indexPath.row]
        let viewModel = UserListItemViewModel(name: model.login, imageURL: model.avatarURL, gitURL: model.htmlURL)
        cell.startCell(model: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserListCell().height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if users.count <= indexPath.row {
            return
        }
        startIndicatorAnimation()
        let userURL = users[indexPath.row].url
        UserDetailCaller().getDetail(userURL: userURL) { response in
            self.stopIndicatorAnimation()
            let detail = UserDetailViewModel(userName: response.login, realName: response.name, imageURL: response.avatarURL, gitURL: response.url, blogURL: response.blog, twitterUsername: response.twitter, followers: response.followers, following: response.following, repositoresURL: response.repos)
            let detailView = DetailViewController()
            detailView.setupController(model: detail)
            self.navigationController?.pushViewController(detailView, animated: true)
        } fail: { errorString in
            self.showError(message: errorString)
        }
    }
    
}
