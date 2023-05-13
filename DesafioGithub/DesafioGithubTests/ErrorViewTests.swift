//
//  ErrorViewTests.swift
//  DesafioGithubTests
//
//  Created by Vinicius Soares Lima on 13/05/23.
//

import XCTest
@testable import DesafioGithub

final class ErrorViewTests: XCTestCase {
    var view: ErrorViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = ErrorViewController()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }
    
    func testErrorView() {
        view?.setup(errorMessage: "menssagem de erro")
        view?.viewDidLoad()
        XCTAssertEqual(view?.label.text, "menssagem de erro")
    }
    
}
