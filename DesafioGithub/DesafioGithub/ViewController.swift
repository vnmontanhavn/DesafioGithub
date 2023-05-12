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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UserListCell.self, forCellReuseIdentifier: UserListCell().getIdentifier())
        self.view.addSubview(self.tableView)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserListCaller().getList { response in
            print(response)
            self.users = response
            self.tableView.reloadData()
        } fail: { errorString in
            let errorView = ErrorView()
            errorView.setup(errorMessage: errorString)
            self.present(errorView, animated: true)
        }
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
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
    
}
