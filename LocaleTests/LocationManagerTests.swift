//
//  LocationManagerTests.swift
//  LocaleTests
//
//  Created by vishal on 8/21/22.
//

import XCTest
@testable import Locale
import Combine
import CoreLocation

class LocationManagerTests: XCTestCase {

    private var manager = LocationManager.shared
    
    func testLocation() {
        
        // Given
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 1.2, longitude: 3.4)
        
        // When
        var actualCoordinate: CLLocationCoordinate2D? = nil
        
        let expectation = self.expectation(description: "waiting validation")
        let cancellable = manager.$coordinate.sink(receiveValue: { values in
            if let values = values {
                actualCoordinate = values
                expectation.fulfill()
            }
        })
        manager.coordinate = expectedCoordinate
        
        // Then
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
        XCTAssertEqual(expectedCoordinate.latitude, actualCoordinate?.latitude)
        XCTAssertEqual(expectedCoordinate.longitude, actualCoordinate?.longitude)
        XCTAssertEqual(expectedCoordinate.latLong, actualCoordinate?.latLong)
    }
}
