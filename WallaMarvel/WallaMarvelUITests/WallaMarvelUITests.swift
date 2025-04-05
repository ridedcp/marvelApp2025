import XCTest

class WallaMarvelUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_heroList_showsTableAndFirstCellCanBeTapped() throws {
        let app = XCUIApplication()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 2), "TableView does not appear")

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell does not exist")

        firstCell.tap()
    }
    
    func test_heroList_opensHeroDetailScreen_onCellTap() throws {
        let app = XCUIApplication()
        
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 2))

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let detailLabel = app.staticTexts["heroDetailNameLabel"]
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 2), "Could not arrive to detail view")
        XCTAssertEqual(detailLabel.label, "3-D Man")
        XCTAssertNotEqual(detailLabel.label, "Iron Man")
    }
    
    func test_searchNoResults_showsEmptyStateLabel() throws {
        let app = XCUIApplication()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 2), "Did not found search bar")

        searchField.tap()
        searchField.typeText("sdfasdfasfd")

        let emptyLabel = app.staticTexts["emptyStateLabel"]
        XCTAssertTrue(emptyLabel.waitForExistence(timeout: 3), "Empty state not appearing")
        XCTAssertEqual(emptyLabel.label, "No heroes found")
    }
    
    func test_heroDetail_canGoBackToList() throws {
        let app = XCUIApplication()
        
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 2))

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let detailLabel = app.staticTexts["heroDetailNameLabel"]
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 2))

        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssertTrue(table.waitForExistence(timeout: 2))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
