//
//  UserInfoCardView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct UserInfoCardView: View {
    
    var completion: () -> ()
    @State var level = "B"
    @State var name = "Gamer"
    
    var body: some View {
        TransparentCardView(colors: [.red, Color.darkRed.opacity(0.5), Color.darkRed])
            .frame(width: screenSize().width / 1.1, height: 220)
            .overlay {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome ")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(Color.white)
                        
                        Text("\(name)!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(Color.white)
                            
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "trophy.fill")
                            Text("Rank:")
                            Text(level)
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            completion()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 50)
                                    .foregroundColor(.darkRed.opacity(0.4))
                                Text("View Profile")
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    .padding(.leading)
                    
                    
                    Spacer()

                    DragableLogo(image: "logoBlue")
                        .glow(.lightPink, radius: 5)
                        .padding(.trailing, 20)
                }
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
