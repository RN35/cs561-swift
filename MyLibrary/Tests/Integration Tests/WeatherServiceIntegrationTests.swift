//
//  WeatherServiceIntegrationTests.swift
//  
//
//  Created by Rohit Nair on 10/13/22.
//

import XCTest
@testable import MyLibrary

final class WeatherServiceIntegrationTests: XCTestCase {

    func testWeatherServiceReturnsCorrectTemperature() async throws {
        // given
        let weatherService = WeatherServiceImpl()
        
        // when
        let temp = try await weatherService.getTemperature()
        
        // then
        XCTAssertEqual(temp, 58)

    }

}
