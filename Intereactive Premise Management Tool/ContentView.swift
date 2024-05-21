import SwiftUI
import RealityKit
import RealityKitContent
import MapKit

var header = "Header"



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
            Image("Wimbledon.svg")
                .resizable()
                .frame(width: 64, height: 64)
                .aspectRatio(contentMode: .fit)
            
            List {
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Full map view")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                })
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Premise Management & Security")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                })
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Ground Level Facilities")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                })
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Security Management")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                });
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Network")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                });
                NavigationLink(destination: {
                    view2()
                }, label: {

                    Text("Media")
                        .foregroundColor(.white)  // Set the modifiers to your liking.
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .cornerRadius(10)
                });
        
                
            }
            .navigationTitle("Lens")

        } detail: {
            List{
                HStack(alignment: .top,
                       spacing: 200){
                    VStack{
                        Text("Henman Hill")
                        Image("Henman_Hill_side")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Response: Spillage")
                        Text("Status: Responder onsite")
                            .foregroundStyle(.orange)
                    }
                    VStack{
                        Text("Center Court")
                        Image("centercourt")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Status: Green")
                            .foregroundStyle(.green)
                    }
                }
                HStack(alignment: .top,
                       spacing: 200){
                    VStack{
                        Text("Southern Village")
                        Image("southernvillage")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Response: Low stock")
                        Text("Status: Responder needed")
                            .foregroundStyle(.red)
                    }
                    VStack{
                        Text("Walled Garden")
                        Image("walledgarden")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Status: Green")
                            .foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("Wimbledon Home")
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


struct view2: View{
    
    @Environment(\.isPresented) var isPresented
    
    @Environment(\.dismiss) var dismiss
    
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
    
    var body: some View {
        if isPresented {
            
            Button(action: {
                
                dismiss()
                
            }, label: {
                
                Text("Back")
                
            })
            
            
        }
        VStack {
            @State var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.434106, longitude: -0.214633),
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004) // Adjust the span for zoom level
            )
            MapView(region: $region)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Premise Management & Security")
        .padding()
        
        
        
    }
}



