//
//  LoyaltyView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI


struct RanksView: View {
    
    @Environment(\.dismiss) var dismiss
    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                CustomBackgroundView()
                
                VStack(spacing: 10) {
                    Text("Bluechip offers its users the chance to join the loyalty program and level up. Learn more below.")
                        .padding(.horizontal)
                        .padding(.top)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            RankCard(rank: "B", description: "Receive a 5% Discount on Room Rentals Starting from the First Hour", image: "logoBlue")
                            RankCard(rank: "A", description: "Receive a 10% Discount.\nAbility to save your progress in story games.", image: "logo")
                            RankCard(rank: "S", description: "Receive a 15% Discount.\nAll previous improvements + the ability to participate in game draws, as well as access to special events.", image: "logoYellow")
                        }
                        .padding(.horizontal)
                        .hideScrollIndicator()
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                completion()
            }
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
                        
                        Text("Loyalty")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

struct RankCard: View {
    let rank: String
    let description: String
    let image: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.semiBlue)
            .overlay {
                HStack {
                    DragableLogo(image: image)
                        .offset(x: 20)

                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Rank \(rank)")
                            .font(.system(size: 22, weight: .regular, design: .monospaced))
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                        Text(description)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(width: 200, alignment: .leading)
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 30)
            }
            .frame(height: 200)
    }
}

#Preview {
    RanksView() {}
}

