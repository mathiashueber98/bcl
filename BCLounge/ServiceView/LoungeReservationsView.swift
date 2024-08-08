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
        NavigationStack {
            ZStack {
                CustomBackgroundView()
                
                VStack(spacing: 60) {
                    Text("Whoops, You don't have any reserves yet.")
                        .font(.system(size: 25, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 30)
                    
                    Image(systemName: "gamecontroller")
                        .font(.system(size: 150))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("It's time to make it to the home screen.")
                        .font(.system(size: 25, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 30)
                }
                .padding(.top, 50)
            }
            .navigationBarBackButtonHidden()
            .modifier(NavBarBackground())
            .navigationTitle("Reservations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        completion()
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear {
            completion()
        }
    }
}

#Preview {
    LoungeReservationsView() {}
}


