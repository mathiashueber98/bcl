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
                
                VStack {
                    
                    Text("Bluechip offers its users the chance to join the loyalty program and level up. Learn more below.")
                        .padding(.horizontal)
                        .padding(.top)
                        .foregroundColor(.gray)
                    
                    VStack {
                        ScrollView {
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: screenSize().width / 1.1, height: 220)
                                .foregroundColor(.semiBlue)
                                .overlay {
                                    HStack {
                                        DragableLogo(image: "logoBlue")
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Text("Rank B")
                                                .font(.system(size: 22, weight: .regular, design: .monospaced))
                                                .foregroundColor(.white)
                                                .padding(.bottom)
                                            
                                            Text("Receive a 5% Discount on Room Rentals Starting from the First Hour")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 200)
                                    }
                                    .padding(.horizontal, 30)
                                }
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: screenSize().width / 1.1, height: 250)
                                .padding(.vertical, 10)
                                .foregroundColor(.semiBlue)
                                .overlay {
                                    HStack {
                                        DragableLogo(image: "logo")
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Text("Rank A")
                                                .font(.system(size: 22, weight: .regular, design: .monospaced))
                                                .foregroundColor(.white)
                                                .padding(.bottom)
                                            
                                            Text("Receive a 10% Discount. \nAbility to save your progress in story games.")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 200)
                                    }
                                    .padding(.horizontal, 30)
                                }
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: screenSize().width / 1.1, height: 250)
                                .foregroundColor(.semiBlue)
                                .overlay {
                                    HStack {
                                        DragableLogo(image: "logoYellow")
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Text("Rank S")
                                                .font(.system(size: 22, weight: .regular, design: .monospaced))
                                                .foregroundColor(.white)
                                                .padding(.bottom)
                                            
                                            Text("Receive a 15% Discount. \nAll previous improvements + the ability to participate in game draws, as well as access to special events.")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 200)
                                    }
                                    .padding(.horizontal, 30)
                                }
                            
                        }
                        .hideScrollIndicator()
                    }
                    
                    Spacer()
                }
            }
            .onAppear {
                completion()
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
                        Text("Loyalty")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

#Preview {
    RanksView(){}
}
