//
//  UserInfoCardView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct UserInfoCardView: View {
    var completion: () -> ()
    @State private var level = "B"
    @State private var name = "Gamer"
    
    var body: some View {
        TransparentCardView(colors: [.red, Color.darkRed.opacity(0.5), Color.darkRed])
            .frame(width: screenSize().width / 1.1, height: 220)
            .overlay {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome \(name)!")
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "trophy.fill")
                            Text("Rank: \(level)")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: completion) {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 50)
                                .foregroundColor(.darkRed.opacity(0.4))
                                .overlay {
                                    Text("View Profile")
                                        .foregroundColor(.white)
                                }
                        }
                        
                        Spacer()
                    }
                    .frame(width: 175)
                    .padding([.top, .leading], 40)                    
                    
                    DragableLogo(image: "logoBlue")
                        .glow(.lightPink, radius: 5)
                }
                .padding(.trailing, 30)
                .onAppear {
                    name = UserDefaults.standard.string(forKey: "name") ?? "Gamer"
                }
            }
    }
}

#Preview {
   TabInitialView()
        .preferredColorScheme(.dark)
}
