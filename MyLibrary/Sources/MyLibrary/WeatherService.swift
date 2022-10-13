import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum ServiceDomain : String {
  case actual = "https://api.openweathermap.org"
  case mock = "http://localhost:3000"
}

class WeatherServiceImpl: WeatherService {
    let url = "\(ServiceDomain.mock.rawValue)/data/2.5/weather?q=corvallis&units=imperial&appid=INSERT_YOUR_API_KEY_HERE"
    
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    print(temperature)
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
