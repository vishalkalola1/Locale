//
//  LocaleTests.swift
//  LocaleTests
//
//  Created by vishal on 8/21/22.
//

import XCTest
@testable import Locale
import Combine

final class SearchPlacesViewModelTests: XCTestCase {

    private var viewModel: SearchPlacesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchPlacesViewModel()
    }
    
    func testTitle() {
        // Given
        let expectedTitle = "Search Places"
        
        // When
        let actualTitle = viewModel.title
        
        // Then
        XCTAssertEqual(actualTitle, expectedTitle)
    }
    
    func testPlaceResultCountWithoutRadiusAndLocation() {
        // Given
        let expectedCount = 50
        
        // When
        var actualCount = 0
        let expectation = self.expectation(description: "waiting validation")
        let cancellable = viewModel.$places.sink(receiveValue: { values in
            if values.count == expectedCount {
                actualCount = values.count
                expectation.fulfill()
            }
        })
        
        viewModel.searchPlaces()
        
        // Then
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testSearchStyle() {
        // Given
        let expectedCount = 2
        
        // When
        let actualCount = viewModel.searchStyle.count
        
        // Then
        XCTAssertEqual(expectedCount, actualCount)
    }
}
