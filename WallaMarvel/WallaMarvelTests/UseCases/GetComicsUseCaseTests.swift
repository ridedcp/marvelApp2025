//
//  GetComicsUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
import XCTest
@testable import WallaMarvel

final class GetComicsUseCaseTests: XCTestCase {
    func test_execute_callsRepositoryWithCorrectHeroId_andReturnsComics() {
        // Given
        let mockRepo = MockMarvelRepository()
        let useCase = GetComics(repository: mockRepo)
        let expectedComics = [
            Comic(id: 1, title: "Infinity War"),
            Comic(id: 2, title: "Civil War")
        ]
        mockRepo.comicsToReturn = expectedComics

        var receivedComics: [Comic]?

        // When
        useCase.execute(heroId: 101) { comics in
            receivedComics = comics
        }

        // Then
        XCTAssertEqual(mockRepo.receivedHeroId, 101)
        XCTAssertEqual(receivedComics?.count, 2)
        XCTAssertEqual(receivedComics?.first?.title, "Infinity War")
    }
}
