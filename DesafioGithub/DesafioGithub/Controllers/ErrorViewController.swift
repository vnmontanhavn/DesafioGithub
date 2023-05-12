//
//  ErrorView.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    private var label: UILabel = UILabel()
    private let icon = UIImageView(image: UIImage(named: "erro"))
    
    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }
    private func setupView() {
        self.view.addSubview(label)
        self.view.addSubview(icon)
    }
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 100),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
            label.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32)
            ])
    }
    
    func setup(errorMessage: String) {
        label.text = errorMessage
        label.numberOfLines = 0
        label.textAlignment = .center
        
    }
}


