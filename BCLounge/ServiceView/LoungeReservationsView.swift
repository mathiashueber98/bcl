//
//  LoungeReservationsView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct LoungeReservationsView: View {
    
    var completion: () -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack {
                    VStack(spacing: 60) {
                        Text("Whoops, You don't have any reserves yet.")
                            .font(.system(size: 25))
                        
                        Image(systemName: "gamecontroller")
                            .font(.system(size: 150))
                        
                        Text("It's time to make it to the home screen.")
                            .font(.system(size: 25))
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.horizontal, 30)
                }
            }
            //MARK: - NavBar
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        
                        Button {
                            completion()
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .overlay {
                        Text("Reservations")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            completion()
        }
    }
}

#Preview {
    LoungeReservationsView(){}
}
