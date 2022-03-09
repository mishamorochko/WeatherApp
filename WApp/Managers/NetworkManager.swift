import Combine
import Foundation

struct NetworkManager {

    enum HTTPError: LocalizedError {
        case addressUnreachable(URL)
        case invalidResponse

        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from the server"
            case .addressUnreachable(let url):
                return "Unreachable URL: \(url.absoluteString)"
            }
        }
    }

    private enum BaseURL {
        static let url = "https://api.openweathermap.org/data/2.5"
    }

    private enum EndPoint {
        static let weather = "/weather"
    }

    func fetchTemperature(lat: Double, lon: Double, units: Units = .metric) -> AnyPublisher<Data, HTTPError> {
        guard let url = URL(string: BaseURL.url + EndPoint.weather + "?lat=\(lat)&lon=\(lon)&units=\(units.rawValue)&appid=\(Constants.apiKey)") else { fatalError("API key not provided.") }
        let request = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw HTTPError.invalidResponse
                }
                return data
            }
            .mapError { error in
                if let error = error as? HTTPError {
                    return error
                } else {
                    return HTTPError.addressUnreachable(url)
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
