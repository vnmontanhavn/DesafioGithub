//
//  DesafioGithubTests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 10/05/23.
//

import XCTest
@testable import DesafioGithub

final class DesafioGithubTests: XCTestCase {
    var view: ViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = ViewController()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }

    func testViewControllerLoad() {
        view?.viewDidLoad()
        XCTAssertEqual(view?.title, "Usuarios")
    }
    func testViewControllerActivety() {
        view?.viewDidLoad()
        XCTAssertEqual(view?.indicator.isHidden, true)
        view?.startIndicatorAnimation()
        XCTAssertEqual(view?.indicator.isHidden, false)
        view?.stopIndicatorAnimation()
        XCTAssertEqual(view?.indicator.isHidden, true)
    }
    func testViewControllerTableview() {
        view?.viewDidLoad()
        XCTAssertEqual(view?.tableView.visibleCells.count, 0)
        let mock1 = UserModel(login: "teste1", id: 0, url: "", htmlURL: "mockHtml", reposURL: "", avatarURL: "")
        view?.users = [mock1]
        view?.tableView.reloadData()
        XCTAssertEqual(view?.tableView.visibleCells.count, 1)
        let cell = view?.tableView.visibleCells[0] as? UserListCell
        XCTAssertEqual(cell?.nameLabel.text, "teste1")
        XCTAssertEqual(cell?.gitLabel.text, "mockHtml")
    }
}
