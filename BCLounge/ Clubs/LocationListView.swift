//
//  LocationListView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

struct LocationListView: View {
        
    @State var clubList: [Lounge] = []
    @State var allClubs: [Lounge] = []

    @State var isShown = false
    @State var isMapShown = false
    @State var isAlertShown = false
    @State var offset = 1000
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack {
                    
                    DividerView()
                        .padding(.top)
                          
                    ScrollView {
                        VStack {
                            ForEach(clubList, id: \.name) { club in
                                LoungeCellView(club: club) {
                                    isShown.toggle()
                                } location: {
                                    isMapShown.toggle()
                                } copy: {
                                    isAlertShown.toggle()
                                    withAnimation {
                                        offset = 0
                                    }
                                }
                                
                                .fullScreenCover(isPresented: $isShown) {
                                    MakeReservationView(club: club)
                                }
                                .fullScreenCover(isPresented: $isMapShown) {
                                    MapView(club: club)
                                }
                            }
                            
                            VStack {
                                
                            }
                            .frame(height: 100)
                        }
                       
                    }
                    .padding(.bottom, screenSize().height > 736 ? 30 : 70)
                    .hideScrollIndicator()
                    
                    Spacer()
                }
                
            }
            //MARK: - NavBar
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Text("Gaming Clubs")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .overlay {
            if isAlertShown {
                Rectangle()
                    .frame(width: 300, height: 100)
                    .cornerRadius(12)
                    .foregroundColor(.gray)
                    .shadow(radius: 10)
                    .overlay {
                        Text("The message has been copied to the clipboard.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    .offset(y: CGFloat(offset))
                    .animation(.bouncy, value: isAlertShown)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                offset = 1000
                                isAlertShown.toggle()
                            }
                        }
                    }
            }
        }
        .onAppear {
            NetworkManager.shared.fetchClubs { result in
                switch result {
                case .success(let clubs):
                    allClubs = clubs
                    clubList = allClubs

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    
    func filterClubs(byCountry country: String, from clubs: [Lounge]) -> [Lounge] {
        return clubs.filter { $0.country == country }
    }
}

#Preview {
    LocationListView()
}
