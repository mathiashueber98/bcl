import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    
    var club: Lounge
    
    private var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(club.latitude ?? "0") ?? 0,
            longitude: Double(club.longtitude ?? "0") ?? 0
        )
    }
    
    var body: some View {
        ZStack {
            MappingView(coordinate: coordinate)
                .preferredColorScheme(.dark)
                .ignoresSafeArea()
            
            VStack {
                mapInfoView
                    .overlay {
                        closeButton
                            .padding(.bottom, 70)
                            .frame(width: screenSize().width, alignment: .leading)
                    }
                Spacer()
                
                
            }
            .foregroundColor(.softBlue)
            .ignoresSafeArea()
        }
    }
    
    private var mapInfoView: some View {
        Rectangle()
            .frame(height: 150)
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
            .overlay {
                VStack {
                    Text(club.name ?? "")
                        .font(.system(size: 22, weight: .bold))
                    
                    Text(club.address ?? "")
                }
                .padding()
                .foregroundColor(.white)
            }
    }
    
    private var closeButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    MapView(club: .example)
}

struct MappingView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        view.removeAnnotations(view.annotations)
        view.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        view.setRegion(region, animated: true)
    }
}
