//
//  UserListCell.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit

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
        
    }
    
    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        gitLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: image.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            gitLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            gitLabel.leftAnchor.constraint(equalTo: image.rightAnchor)
            ])
    }
}

extension UserListCell: CellProtocol {
    func height() -> CGFloat {
        return 50
    }
}
