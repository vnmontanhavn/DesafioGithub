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
    lazy var realName = UILabel()
    lazy var followers = UILabel()
    lazy var following = UILabel()
    lazy var linkBlog = UIButton()
    lazy var linkGit = UIButton()
    lazy var linkTwitter = UIButton()
    var linkDelegate: LinkProtocol? = nil
    var model: UserDetailViewModel? = nil
    
    func setupCell(model: UserDetailViewModel, linkDelegate: LinkProtocol) {
        self.linkDelegate = linkDelegate
        self.model = model
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = false
        self.realName.text = model.realName
        self.followers.text = "followers: \(model.followers)"
        self.following.text = "following: \(model.following)"
        self.linkBlog.setTitle("Blog", for: .normal)
        self.linkBlog.setTitleColor(.blue, for: .normal)
        self.linkBlog.setTitleColor(.red, for: .selected)
        self.linkBlog.addTarget(self, action: #selector(linkBlogAction(_:)), for: .touchUpInside)
        self.linkGit.setTitle("Git", for: .normal)
        self.linkGit.setTitleColor(.blue, for: .normal)
        self.linkGit.addTarget(self, action: #selector(linkGitAction(_:)), for: .touchUpInside)
        self.linkTwitter.setTitle("Twitter", for: .normal)
        self.linkTwitter.setTitleColor(.blue, for: .normal)
        self.linkTwitter.addTarget(self, action: #selector(linkTwitterAction(_:)), for: .touchUpInside)
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
    @objc func linkBlogAction(_ sender:UIButton!) {
        guard let model = self.model else {
            return
        }
        if let url = URL(string: model.blogURL){
            linkDelegate?.openLink(url: url)
        }
    }
    
    @objc func linkGitAction(_ sender:UIButton!) {
        guard let model = self.model else {
            return
        }
        if let url = URL(string: model.gitURL){
            linkDelegate?.openLink(url: url)
        }
    }
    
    @objc func linkTwitterAction(_ sender:UIButton!) {
        guard let model = self.model else {
            return
        }
       // let address = "https://www.twitter.com/ \(model.twitterUsername)"
        //print(address)
        if let url = URL(string: "https://www.twitter.com/\(model.twitterUsername)"){
            linkDelegate?.openLink(url: url)
        }
    }
}

extension DetailInfoCell: CellProtocol {
    func height() -> CGFloat {
        return 100
    }
}
