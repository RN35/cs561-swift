//
//  WeatherModelTests.swift
//  
//
//  Created by Rohit Nair on 10/13/22.
//

import XCTest
@testable import MyLibrary

final class WeatherModelTests: XCTestCase {


    func testInit() throws {
        // Given
        let main = Weather.Main(temp: 58)
        
        
        // When
        let weather = Weather(main: main)
        
        // Then
        XCTAssert(weather.main.temp == 58)
    }
    
    func testWeatherModelForValidTemperature() throws {
        // Given
        let decoder = JSONDecoder()
        let data = Data("{\"main\": {\"temp\":58}}".utf8)
        
        // When
        let container = try decoder.decode(Weather.self, from: data)
        
        // Then
        XCTAssertNotNil(container)
        XCTAssert(container.main.temp == 58.0)
    }
    
    func testWeatherModelForInvalidTemperature() {
        // Given
        let decoder = JSONDecoder()
        let data = Data("{\"main\": {\"temp\":\"invalid temp\"}}".utf8)
        
        // When
        let weather = try? decoder.decode(Weather.self, from: data)
        
        // Then
        XCTAssert(weather == nil)
    }
}
