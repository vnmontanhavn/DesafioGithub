//
//  DesafioGithubTests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import XCTest
@testable import DesafioGithub

class Mock: CallerProtocol {
    var delegate: DesafioGithub.CallResponseDelegate?
    required init(delegate: DesafioGithub.CallResponseDelegate?) {
        self.delegate = delegate
    }
    
    func call() {
        let list = [UserModel(login: "Nome", id: 0, url: "", htmlURL: "Endereço", reposURL: "", avatarURL: "")]
        delegate?.success(response: list)
    }
    func call(userURL: String?) {
        let detail = DetailModel(login: "testeNome", url: "testeGit", repos: "", followers: 100, following: 200)
        delegate?.success(response: detail)
    }
}

final class DesafioGithubTests: XCTestCase {
    var view: ViewController?
    var mockDelegate: Mock?
    var viewModel: ViewModelList?
    override func setUpWithError() throws {
        viewModel = ViewModelList()
        guard let viewModel = viewModel else {
            fatalError("load Error")
        }
        let model = Model(delegate: viewModel)
        viewModel.model = model
        mockDelegate = Mock(delegate: model)
        model.listCallDelegate = mockDelegate
        model.detailCallDelegate = mockDelegate
        view = viewModel.setupController() as? ViewController
        view?.view.layoutIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }

    func testViewControllerLoad() {
        view?.viewDidLoad()
        view?.viewDidAppear(false)
        XCTAssertEqual(view?.title, "Usuarios")
    }
    func testViewControllerActivety() {
        view?.viewDidLoad()
        view?.viewDidAppear(false)
        XCTAssertEqual(view?.indicator.isHidden, false)
        view?.stopIndicatorAnimation()
        XCTAssertEqual(view?.indicator.isHidden, true)
    }
    func testViewControllerTableview() {
        
        guard let view = self.view else {
            XCTAssertTrue(false)
            return
        }
        view.viewDidLoad()
        view.viewDidAppear(false)
        XCTAssertEqual(view.tableView.visibleCells.count, 1)
        let mock1 = UserListItemViewModel(name: "teste1", imageURL: "mockHtml", gitURL: "", apiURL: "www.com.br")
        view.searchBar.text = ""
        view.users = [mock1, mock1]
        view.usersFiltred = view.users
        view.tableView.reloadData()
        XCTAssertEqual(view.tableView.visibleCells.count, 2)
    }
    func testGetDetail() {
        guard let view = view else {
            fatalError("load error")
        }
        let navigation = UINavigationController(rootViewController: view)
        view.tableView(view.tableView , didSelectRowAt: IndexPath(row: 0, section: 0))

        let expectation = expectation(description: "TextMatching")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            guard let controller = navigation.topViewController else {
                fatalError("load error")
            }
            
            XCTAssert(controller.isKind(of: DetailViewController.self))
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
