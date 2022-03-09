import CoreLocation
import CoreLocationUI
import MapKit

final class MapViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    // MARK: Published

    @Published var userLocationRegion = MKCoordinateRegion()
    @Published var cityName = "San Jose"
    @Published var localTemperature = "16°C"

    // MARK: Private

    private let manager = CLLocationManager()

    // MARK: - Lifecycle

    override init() {
        super.init()
        manager.delegate = self
    }

    // MARK: - API

    func requestLocation() {
        manager.requestLocation()
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
