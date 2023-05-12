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
    }
    
    func setupController(model: UserDetailViewModel){
        self.model = model
        self.title = model.userName
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

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
