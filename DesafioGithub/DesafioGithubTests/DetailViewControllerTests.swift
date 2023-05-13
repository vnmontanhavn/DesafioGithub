//
//  DetailViewControllerTests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import XCTest
@testable import DesafioGithub

final class DetailViewControllerTests: XCTestCase {
    var view: DetailViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = DetailViewController()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }
    
    func testDetailView() {
        let userMock = UserDetailViewModel(userName: "testeNome", realName: "testeNomeReal", imageURL: "", gitURL: "testeGit", blogURL: "testeBlog", twitterUsername: "testeTwitter", followers: 100, following: 200, repositoresURL: "")
        view?.setupController(model: userMock)
        XCTAssertEqual(view?.title, "testeNome")
        view?.viewDidLoad()
        XCTAssertEqual(view?.view.backgroundColor, .blue)
        view?.tableView.reloadData()
        XCTAssertEqual(view?.tableView.visibleCells.count, 1)
    }
}
