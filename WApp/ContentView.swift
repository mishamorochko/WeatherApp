import MapKit
import SwiftUI

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.507222,
            longitude: -0.1275
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            VStack {
                infoBlock
                    .frame(width: 320, height: 90)
                    .background(Color(red: 36 / 255, green: 34 / 255, blue: 49 / 255, opacity: 1.0))
                    .cornerRadius(12)
                    .padding(.bottom, 50)
                Map(coordinateRegion: $region)
                    .frame(width: 320, height: 450)
                    .cornerRadius(12)
            }
        }
    }

    private var infoBlock: some View {
        HStack(spacing: 20) {
            Text("London")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .font(.title)
            Text("7°C")
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
