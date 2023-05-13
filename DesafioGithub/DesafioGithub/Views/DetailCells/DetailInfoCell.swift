//
//  DetailInfoCell.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit

protocol LinkProtocol {
    func openLink(url: URL)
}

class DetailInfoCell: UITableViewCell {
    var realName = UILabel()
    var followers = UILabel()
    var following = UILabel()
    var linkBlog = UIButton()
    var linkGit = UIButton()
    var linkTwitter = UIButton()
    var linkDelegate: LinkProtocol? = nil
    var model: UserDetailViewModel? = nil
    
    func setupCell(model: UserDetailViewModel, linkDelegate: LinkProtocol) {
        self.linkDelegate = linkDelegate
        self.model = model
        self.realName.text = model.realName
        self.followers.text = "followers: \(model.followers)"
        self.following.text = "following: \(model.following)"
        self.linkBlog.setTitle("Blog", for: .normal)
        self.linkBlog.setTitleColor(.blue, for: .normal)
        self.linkGit.setTitle("Git", for: .normal)
        self.linkGit.setTitleColor(.blue, for: .normal)
        self.linkTwitter.setTitle("Twitter", for: .normal)
        self.linkTwitter.setTitleColor(.blue, for: .normal)
        setupView()
    }
    private func setupView() {
        self.addSubview(realName)
        self.addSubview(followers)
        self.addSubview(following)
        self.addSubview(linkBlog)
        self.addSubview(linkGit)
        self.addSubview(linkTwitter)
        setupConstrint()
    }
    
    private func setupConstrint() {
        self.realName.translatesAutoresizingMaskIntoConstraints = false
        self.followers.translatesAutoresizingMaskIntoConstraints = false
        self.following.translatesAutoresizingMaskIntoConstraints = false
        self.linkBlog.translatesAutoresizingMaskIntoConstraints = false
        self.linkGit.translatesAutoresizingMaskIntoConstraints = false
        self.linkTwitter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.realName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            self.realName.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.followers.topAnchor.constraint(equalTo: self.realName.bottomAnchor, constant: 8),
            self.followers.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            self.following.topAnchor.constraint(equalTo: self.followers.topAnchor),
            self.following.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            self.linkBlog.topAnchor.constraint(equalTo: followers.bottomAnchor, constant: 8),
            self.linkBlog.leftAnchor.constraint(equalTo: followers.leftAnchor),
            self.linkBlog.widthAnchor.constraint(equalToConstant: 100),
            self.linkBlog.heightAnchor.constraint(equalToConstant: 20),
            self.linkGit.topAnchor.constraint(equalTo: linkBlog.topAnchor),
            self.linkGit.widthAnchor.constraint(equalToConstant: 100),
            self.linkGit.heightAnchor.constraint(equalToConstant: 20),
            self.linkGit.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.linkTwitter.topAnchor.constraint(equalTo: linkBlog.topAnchor),
            self.linkTwitter.rightAnchor.constraint(equalTo: following.rightAnchor),
            self.linkTwitter.widthAnchor.constraint(equalToConstant: 100),
            self.linkTwitter.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
}

extension DetailInfoCell: CellProtocol {
    func height() -> CGFloat {
        return 100
    }
}
