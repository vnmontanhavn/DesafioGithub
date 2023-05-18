//
//  DetailViewControllerTests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import XCTest
@testable import DesafioGithub

class RepoMock: CallerProtocol {
    var delegate: DesafioGithub.CallResponseDelegate?
    required init(delegate: DesafioGithub.CallResponseDelegate?) {
        self.delegate = delegate
    }
    
    func call() {
    }
    func call(userURL: String?) {
        let repository1 = RepositoryModel(name: "elemento 1", htmlUrl: "")
        let repository2 = RepositoryModel(name: "elemento 2", htmlUrl: "")
        let repository3 = RepositoryModel(name: "elemento 3", htmlUrl: "")
        let list = [repository1, repository2, repository3]
        delegate?.success(response: list)
    }
}

final class DetailViewControllerTests: XCTestCase {
    var view: DetailViewController?
    var mockDelegate: RepoMock?
    override func setUpWithError() throws {
        
        view = DetailViewController()
        mockDelegate = RepoMock(delegate: view)
        view?.repoCallDelegate = mockDelegate
        let userMock = UserDetailViewModel(userName: "testeNome", realName: "testeNomeReal", imageURL: "", gitURL: "testeGit", blogURL: "testeBlog", twitterUsername: "testeTwitter", followers: 100, following: 200, repositoresURL: "")
        view?.setupController(model: userMock)
        view?.view.layoutIfNeeded()
        let window = UIWindow(frame: UIScreen.main.bounds)
          window.makeKeyAndVisible()
          window.rootViewController = view
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }
    
    func testDetailView() {
        guard let view = self.view else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertEqual(view.title, "testeNome")
        view.viewDidLoad()
        view.repoCallDelegate = mockDelegate
        view.viewWillAppear(false)
        XCTAssertEqual(view.view.backgroundColor, .blue)
        XCTAssertEqual(view.tableView.visibleCells.count, 5)
    }
}
