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
        let detail = DetailModel(login: "", avatarURL: "", name: "", url: "", blog: "", twitter: "", repos: "", followers: 1, following: 2)
        delegate?.success(response: detail)
    }
}

final class DesafioGithubTests: XCTestCase {
    var view: ViewController?
    var mockDelegate: Mock?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = ViewController()
        mockDelegate = Mock(delegate: view)
        view?.listCallDelegate = mockDelegate
        view?.detailCallDelegate = mockDelegate
        view?.view.layoutIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }

    func testViewControllerLoad() {
        view?.viewDidLoad()
        view?.listCallDelegate = mockDelegate
        view?.detailCallDelegate = mockDelegate
        view?.viewDidAppear(false)
        XCTAssertEqual(view?.title, "Usuarios")
    }
    func testViewControllerActivety() {
        view?.viewDidLoad()
        view?.listCallDelegate = mockDelegate
        view?.detailCallDelegate = mockDelegate
        view?.viewDidAppear(false)
        XCTAssertEqual(view?.indicator.isHidden, true)
        view?.startIndicatorAnimation()
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
        view.listCallDelegate = mockDelegate
        view.detailCallDelegate = mockDelegate
        view.viewDidAppear(false)
        XCTAssertEqual(view.tableView.visibleCells.count, 1)
        let mock1 = UserModel(login: "teste1", id: 0, url: "", htmlURL: "mockHtml", reposURL: "", avatarURL: "")
        view.searchBar.text = ""
        view.users = [mock1, mock1]
        view.usersFiltred = view.users
        view.tableView.reloadData()
        XCTAssertEqual(view.tableView.visibleCells.count, 2)
    }
}
