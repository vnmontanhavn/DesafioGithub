//
//  ErrorView.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    var label: UILabel = UILabel()
    private let icon = UIImageView(image: UIImage(named: "erro"))
    private let background = UIView()
    
    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }
    private func setupView() {
        self.view.addSubview(background)
        self.view.addSubview(label)
        self.view.addSubview(icon)
        self.background.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func close(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 100),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, constant: -32),
            background.topAnchor.constraint(equalTo: icon.topAnchor, constant: -20),
            background.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            background.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -20),
            background.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 20)
            ])
    }
    
    func setup(errorMessage: String) {
        label.text = errorMessage
        label.numberOfLines = 0
        label.textAlignment = .center
        
    }
}


