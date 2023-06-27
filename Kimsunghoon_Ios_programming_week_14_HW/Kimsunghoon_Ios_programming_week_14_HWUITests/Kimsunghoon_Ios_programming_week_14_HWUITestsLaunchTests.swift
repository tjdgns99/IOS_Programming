//
//  Kimsunghoon_Ios_programming_week_14_HWUITestsLaunchTests.swift
//  Kimsunghoon_Ios_programming_week_14_HWUITests
//
//  Created by Capstone on 2023/06/11.
//

import XCTest

final class Kimsunghoon_Ios_programming_week_14_HWUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
