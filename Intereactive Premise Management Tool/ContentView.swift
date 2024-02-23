import SwiftUI
import RealityKit
import RealityKitContent
import MapKit

struct ContentView: View {
    
    struct MapView: UIViewRepresentable {
      @Binding var region: MKCoordinateRegion
      func makeUIView(context: Context) -> MKMapView {
        // create a 3D Camera
          let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate=CLLocationCoordinate2D(latitude: 51.434106, longitude: -0.214633)
          mapCamera.pitch = 45
          mapCamera.altitude = 100 // example altitude
          mapCamera.heading = 45
        let mapView = MKMapView()
        mapView.mapType = MKMapType.satelliteFlyover
        mapView.isScrollEnabled = false
        mapView.isPitchEnabled = true
        mapView.camera = mapCamera
        return mapView
      }
        
      func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
      }
      func makeCoordinator() -> Coordinator {
        Coordinator(self)
      }
      class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
          self.parent = parent
        }
      }
    }
  

    @State var showImmersiveSpace = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
  
    var body: some View {
        NavigationSplitView {
            List {
                Button("Premise Management & Security") {
                    
                };
                Button("Ground Level Facilities"){};
                Button("Security Management"){};
                Button("Network"){};
                Button("Media"){};
            }
            .navigationTitle("Lens")

        } detail: {
            VStack {
              @State var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.434106, longitude: -0.214633),
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004) // Adjust the span for zoom level

              )
                MapView(region: $region)
                  .edgesIgnoringSafeArea(.all)

            }
            .navigationTitle("Wimbledon")
            .padding()
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}
