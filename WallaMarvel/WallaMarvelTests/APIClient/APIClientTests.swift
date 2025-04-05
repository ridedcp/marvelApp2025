//
//  APIClientTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 5/4/25.
//

import XCTest
@testable import WallaMarvel

final class APIClientTests: XCTestCase {
    
    private var client: APIClient!
    
    override func setUp() {
        super.setUp()
        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockError = nil
        client = APIClient.makeMockedClient()
    }
    
    override func tearDown() {
        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockError = nil
        client = nil
        super.tearDown()
    }

    func test_getHeroes_decodesCharacterDataContainerSuccessfully() throws {
        // Given
        let json = """
        {
            "data": {
                "offset": 0,
                "limit": 20,
                "total": 100,
                "count": 1,
                "results": [
                    {
                        "id": 123,
                        "name": "Test Hero",
                        "thumbnail": {
                            "path": "http://example.com/image",
                            "extension": "jpg"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = json
        
        let expectation = self.expectation(description: "Wait for response")
        
        // When
        client.getHeroes(offset: 0, query: nil) { container in
            // Then
            XCTAssertEqual(container.characters.first?.id, 123)
            XCTAssertEqual(container.characters.first?.name, "Test Hero")
            XCTAssertEqual(container.characters.first?.thumbnail.path, "http://example.com/image")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getComics_decodesComicsSuccessfully() throws {
        // Given
        let json = """
        {
            "data": {
                "results": [
                    {
                        "id": 42,
                        "title": "Infinity Gauntlet"
                    },
                    {
                        "id": 43,
                        "title": "Secret Wars"
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = json
        
        let expectation = self.expectation(description: "Wait for comics response")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 123) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(receivedComics?.count, 2)
        XCTAssertEqual(receivedComics?.first?.id, 42)
        XCTAssertEqual(receivedComics?.first?.title, "Infinity Gauntlet")
        XCTAssertEqual(receivedComics?.last?.title, "Secret Wars")
    }
    
    func test_getComics_whenNetworkError_returnsEmptyArray() {
        // Given
        MockURLProtocol.mockError = NSError(domain: "test", code: -1)
        
        let expectation = self.expectation(description: "Wait for network error")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 888) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedComics, [], "Expected empty array on network error")
    }
    
    func test_getComics_whenDecodingFails_returnsEmptyArray() {
        // Given
        let invalidJSON = """
        {
            "data": {
                "wrongKey": []
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = invalidJSON
        
        let expectation = self.expectation(description: "Wait for failure response")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 999) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedComics, [], "Expected empty array on decoding error")
    }
}
