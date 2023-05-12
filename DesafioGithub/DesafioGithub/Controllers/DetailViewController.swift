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
    
    private var avatarImage = UIImageView(frame: .zero)
    private var userNameLabel = UILabel()
    private var realNameLabel = UILabel()
    private var userGitLink = UIButton()
    private var userBlogLink = UIButton()
    private var userTwitterLink = UIButton()
    private let repoTableView = UITableView()
    private var model: UserDetailViewModel? = nil
    ///Métodos
    
    func setupController(model: UserDetailViewModel){
        self.model = model
        let url = URL(string: model.imageURL)
        avatarImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        userNameLabel.text = model.userName
        realNameLabel.text = model.realName
        userGitLink.titleLabel?.text = "Git"
        userGitLink.isHidden = model.gitURL.count > 0 ? false : true
        userBlogLink.titleLabel?.text = "Blog"
        userBlogLink.isHidden = model.blogURL.count > 0 ? false : true
        userTwitterLink.titleLabel?.text = "Twitter"
        userTwitterLink.isHidden = model.twitterUsername.count > 0 ? false : true
        
    }
    
}
