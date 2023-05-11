//
//  ViewController.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserListCaller().getList { response in
            print(response)
        }
        let errorView = ErrorView()
        errorView.setup(errorMessage: "teste de erro")
        self.present(errorView, animated: true)
        
    }
}

