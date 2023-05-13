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
    
    private let tableView = UITableView()
    private var model: UserDetailViewModel? = nil
    ///Métodos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        self.setupConstraints()
        self.setupTableview()
    }
    
    private func setupTableview() {
        self.tableView.register(DetailImageCell.self, forCellReuseIdentifier: DetailImageCell().getIdentifier())
    }
    
    func setupController(model: UserDetailViewModel){
        self.model = model
        self.title = model.userName
    }
    
    private func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.model else {
            return 0
        }
        return 1
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
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return DetailImageCell().height()
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
}
