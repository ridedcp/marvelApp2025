//
//  HeroDetailPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class HeroDetailPresenterTests: XCTestCase {

    // MARK: - Mocks y dependencias

    private var presenter: HeroDetailPresenter!
    private var mockUI: MockHeroDetailUI!
    private var mockUseCase: MockGetComicsUseCase!
    private var hero: CharacterDataModel!

    // MARK: - Setup / Teardown

    override func setUp() {
        super.setUp()

        hero = CharacterDataModel.mock(id: 99, name: "Test Hero", thumbnail: Thumbnail(path: "http://path/to/image", extension: "jpg"))

        mockUI = MockHeroDetailUI()
        mockUseCase = MockGetComicsUseCase()
        mockUseCase.comicsToReturn = [
            Comic(id: 1, title: "Comic One"),
            Comic(id: 2, title: "Comic Two")
        ]

        presenter = HeroDetailPresenter(hero: hero, getComicsUseCase: mockUseCase)
        presenter.ui = mockUI
    }

    override func tearDown() {
        presenter = nil
        mockUI = nil
        mockUseCase = nil
        hero = nil
        super.tearDown()
    }

    func test_screenTitle_returnsExpectedTitle() {
        XCTAssertEqual(presenter.screenTitle(), "Hero Detail")
    }

    func test_onViewLoaded_showsHeroAndComics() {
        // When
        presenter.onViewLoaded()

        // Then
        XCTAssertEqual(mockUI.receivedHeroName, "Test Hero")

        let expectedURL = URL(string: "http://path/to/image/portrait_uncanny.jpg")
        XCTAssertEqual(mockUI.receivedHeroURL, expectedURL)
        XCTAssertEqual(mockUseCase.executedHeroId, 99)
        XCTAssertEqual(mockUI.receivedComics?.count, 2)
        XCTAssertEqual(mockUI.receivedComics?.first?.title, "Comic One")
    }
}

