import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    //Unit Tests
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    
    // Integration Tests
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumberActual() async {
        // Given

        let myLibrary = MyLibrary()

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }
    
    func testIsLuckyBecauseWeatherHasAnEightActual() async throws {
        // Given

        let myLibrary = MyLibrary()

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }
    func testWeatherModel_ShouldPassIfTempIsValid() {
        let decoder = JSONDecoder()
        let data = Data("{\"main\": {\"temp\":58}}".utf8)
        do {
            let container = try decoder.decode(Weather.self, from: data)
            XCTAssertNotNil(container)
            XCTAssert(container.main.temp == 58.0)
        } catch {
            XCTFail("Failed to decode temp from json")
        }
    }
    func testWeatherModel_ShouldFailIfTempIsInvalid() {
        let decoder = JSONDecoder()
        let data = Data("{\"main\": {\"temp\":\"invalid temp\"}}".utf8)
        do {
            let container = try decoder.decode(Weather.self, from: data)
            XCTFail("Should not have been possible to decode temp for invalid input")
        } catch {
            XCTAssert(true == true)
        }
    }

}
