import CoreLocationUI
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var mapViewModel = MapViewModel()

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            VStack {
                infoBlock
                    .frame(width: 320, height: 90)
                    .background(Color(red: 36 / 255, green: 34 / 255, blue: 49 / 255, opacity: 1.0))
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                map
                    .disabled(true)
                    .frame(width: 320, height: 500)
                    .cornerRadius(12)
                locationButton
                    .cornerRadius(12)
                    .padding()
                    .tint(Color(red: 36 / 255, green: 34 / 255, blue: 49 / 255, opacity: 1.0))
                    .foregroundColor(.white)
            }
        }
    }

    private var locationButton: some View {
        LocationButton {
            mapViewModel.requestLocation()
        }
    }

    private var map: some View {
        Map(coordinateRegion: $mapViewModel.userLocationRegion, showsUserLocation: true)
    }

    private var infoBlock: some View {
        HStack(spacing: 20) {
            Text(mapViewModel.cityName)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .font(.title)
            Text(mapViewModel.localTemperature)
                .foregroundColor(.white)
                .padding(.trailing, 32)
                .font(.title)
        }
    }

    private var background: some View {
        Color(red: 28 / 255, green: 28 / 255, blue: 35 / 255, opacity: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
