//
//  LocationListView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

struct LocationListView: View {
    @State private var clubList: [Lounge] = []
    @State private var allClubs: [Lounge] = []
    
    @State private var isShown = false
    @State private var isMapShown = false
    @State private var isAlertShown = false
    @State private var offset: CGFloat = 1000
    
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
                                    withAnimation {
                                        offset = 0
                                        isAlertShown = true
                                    }
                                }
                                .fullScreenCover(isPresented: $isShown) {
                                    MakeReservationView(club: club)
                                }
                                .fullScreenCover(isPresented: $isMapShown) {
                                    MapView(club: club)
                                }
                            }
                            
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                    .padding(.bottom, screenSize().height > 736 ? 60 : 70)
                    .hideScrollIndicator()
                    
                    Spacer()
                }
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Text("Gaming Clubs")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .overlay {
            if isAlertShown {
                alertOverlay
                    .offset(y: offset)
                    .animation(.bouncy, value: isAlertShown)
                    .onAppear {
                        hideAlertAfterDelay()
                    }
            }
        }
        .onAppear {
            fetchClubs()
        }
    }
    
    private var alertOverlay: some View {
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
    }
    
    private func fetchClubs() {
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
    
    private func hideAlertAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                offset = 1000
                isAlertShown = false
            }
        }
    }
}


#Preview {
    TabInitialView()
}
