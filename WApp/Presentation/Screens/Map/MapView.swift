import CoreLocationUI
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel()

    var body: some View {
        ZStack {
            AppColor.background
                .ignoresSafeArea()
            VStack {
                infoBlock
                    .frame(width: 320, height: 90)
                    .background(AppColor.primary)
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                map
                    .disabled(true)
                    .frame(width: 320, height: 500)
                    .cornerRadius(12)
            }
        }
        .onAppear {
            mapViewModel.requestLocation()
            mapViewModel.fetchWeather()
        }
    }

    private var map: some View {
        Map(coordinateRegion: $mapViewModel.userLocationRegion)
    }

    private var infoBlock: some View {
        HStack(spacing: 20) {
            Text(mapViewModel.cityName)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .font(.title)
            Text(mapViewModel.localTemperature)
                .foregroundColor(.white)
                .padding(.trailing, 16)
                .font(.title)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
