//
//  GetHeroesUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import Foundation
import XCTest
@testable import WallaMarvel

final class GetHeroesUseCaseTests: XCTestCase {
    func test_execute_callsRepositoryWithCorrectParams_andPropagatesResult() {
        // Given
        let mockRepo = MockMarvelRepository()
        let useCase = GetHeroes(repository: mockRepo)
        let expectedResult = CharacterDataContainer(count: 1, limit: 20, total: 100, offset: 0, characters: [CharacterDataModel.mock()])
        
        mockRepo.resultContainer = expectedResult

        var receivedResult: CharacterDataContainer?

        // When
        useCase.execute(offset: 0, query: "spider") { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(mockRepo.receivedOffset, 0)
        XCTAssertEqual(mockRepo.receivedQuery, "spider")
        XCTAssertEqual(receivedResult?.characters.count, 1)
        XCTAssertEqual(receivedResult?.characters.first?.name, "Mock Hero")
    }
}
