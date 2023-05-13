//
//  DetailInfoCelltests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import XCTest
@testable import DesafioGithub

class mockProtocol: LinkProtocol {
    func openLink(url: URL) {
        //
    }
}

final class DetailInfoCelltests: XCTestCase {
    var view: DetailInfoCell?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = DetailInfoCell()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }
    
    func testDetailInfoCell() {
        let userMock = UserDetailViewModel(userName: "testeNome", realName: "testeNomeReal", imageURL: "", gitURL: "testeGit", blogURL: "testeBlog", twitterUsername: "testeTwitter", followers: 100, following: 200, repositoresURL: "")
        view?.setupCell(model: userMock, linkDelegate: mockProtocol())
        
        XCTAssertEqual(view?.realName.text, "testeNomeReal")
        XCTAssertEqual(view?.followers.text, "followers: 100")
        XCTAssertEqual(view?.following.text, "following: 200")
        XCTAssertEqual(view?.linkBlog.titleLabel?.text, "Blog")
        XCTAssertEqual(view?.linkGit.titleLabel?.text, "Git")
        XCTAssertEqual(view?.linkTwitter.titleLabel?.text, "Twitter")
    }
}
