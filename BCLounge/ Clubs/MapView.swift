//
//  MapView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI
import MapKit


struct MapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var club: Lounge
    
    var body: some View {
        ZStack {
            MappingView(coordinate: CLLocationCoordinate2D(
                latitude: Double(club.latitude ?? "0") ?? 0,
                longitude: Double(club.longtitude ?? "0") ?? 0)
            )
            .preferredColorScheme(.dark)
            .ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .frame(height: 150)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    .overlay {
                        VStack {
                            Text(club.name ?? "")
                                .font(.system(size: 22, weight: .bold))
                            
                            
                            Text(club.address ?? "")
                        }
                        .padding(.top, 30)
                        
                        .foregroundColor(.white)
                    }
                    .overlay {
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
                
                Spacer()
                
            }
            .foregroundColor(.softBlue)
            .ignoresSafeArea()
            
        }
        
    }
    
    func openAppleMaps() {
        guard let address = club.address else { return }
        
        let url = URL(string: "http://maps.apple.com/?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://maps.apple.com/?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!, options: [:], completionHandler: nil)
        }
    }
    
    func openGoogleMaps() {
        guard let address = club.address else { return }
        
        let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "https://www.google.com/maps/search/?api=1&query=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!, options: [:], completionHandler: nil)
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
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        view.setRegion(region, animated: true)
    }
}
