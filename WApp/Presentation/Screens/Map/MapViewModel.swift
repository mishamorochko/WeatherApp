import CoreLocation
import CoreLocationUI
import MapKit
import Combine

final class MapViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    // MARK: Published

    @Published var userLocationRegion = MKCoordinateRegion()
    @Published var cityName = " "
    @Published var localTemperature = " "

    // MARK: Private

    private let networkManager = NetworkManager()
    private let locationManager = CLLocationManager()
    private var cancellable: AnyCancellable?

    // MARK: - Lifecycle

    override init() {
        super.init()
        locationManager.delegate = self
    }

    deinit {
        cancellable = nil
    }

    // MARK: - API

    func requestLocation() {
        locationManager.requestLocation()
    }

    func fetchWeather() {
        cancellable = networkManager.fetchTemperature(
            lat: userLocationRegion.center.latitude,
            lon: userLocationRegion.center.longitude
        )
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            }, receiveValue: { [ weak self] data in
                guard let viewModel = self else { return }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else { return }
                viewModel.cityName = weather.name
                viewModel.localTemperature = "\(weather.main.temp)°C"
            })
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        userLocationRegion = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(
                latitudeDelta: 0.5,
                longitudeDelta: 0.5
            )
        )
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
