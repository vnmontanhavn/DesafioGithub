//
//  UserListCell.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit
import SDWebImage

class UserListCell: UITableViewCell {
    
    var nameLabel: UILabel = UILabel()
    var gitLabel: UILabel = UILabel()
    var image: UIImageView = UIImageView(frame: .zero )
    
    func clearSetup() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.nameLabel = UILabel()
        self.gitLabel = UILabel()
        self.image = UIImageView(frame: .zero )
        self.addSubview(nameLabel)
        self.addSubview(gitLabel)
        self.addSubview(image)
        setupConstraints()
    }
    
    func startCell(model: UserListItemViewModel) {
        clearSetup()
        self.nameLabel.text = model.name
        self.gitLabel.text = model.gitURL
        imageSetup(urlString: model.imageURL)
    }
    
    func imageSetup(urlString: String) {
        let url = URL(string: urlString)
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.contentMode = .scaleAspectFit
        self.image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        self.image.clipsToBounds = true
        self.image.layer.cornerRadius = 25
    }
    
    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        gitLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1),
            nameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            gitLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            gitLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8)
            ])
    }
}

extension UserListCell: CellProtocol {
    func height() -> CGFloat {
        return 70
    }
}
