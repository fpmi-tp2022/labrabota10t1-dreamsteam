//
//  BusikUITests.swift
//  BusikUITests
//
//  Created by Kanstantin Venger on 5/31/22.
//

import XCTest

class BusikUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_has_sign_in(){
        
        let app = XCUIApplication();
        app.launch();
        app/*@START_MENU_TOKEN@*/.buttons["Create account"].staticTexts["Create account"]/*[[".buttons[\"Create account\"].staticTexts[\"Create account\"]",".staticTexts[\"Create account\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap();
        app.buttons["Sign Up"].tap();
        XCTAssert(app.staticTexts["Field can't be empty"].exists);
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
