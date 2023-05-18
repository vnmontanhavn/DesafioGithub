//
//  DetailRepositoryCell.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit

class DetailRepositoryCell: UITableViewCell {
    lazy var title = UILabel()
    
    func setupCell(titleText: String){
        self.title.text = titleText
        self.addSubview(self.title)
        setupConstraints()
    }
    
    func setupConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            self.title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }
}

extension DetailRepositoryCell: CellProtocol {
    func height() -> CGFloat {
        return 50
    }
}
