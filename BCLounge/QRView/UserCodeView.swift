//
//  UserCodeView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

struct UserCodeView: View {
    @State private var user = User()
    @State private var code = "00 00 00 00"
    @State private var level = "B"
    @State private var isSheetShown = false
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack {
                    qrCodeView
                    
                    Text("Show the QR code to the manager")
                        .padding()
                        .foregroundColor(.gray)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            codeView
                            rankView
                        }
                        .padding(.horizontal, 10)
                    }
                    .frame(width: screenSize().width - 20, alignment: .leading)
                    .hideScrollIndicator()
                    
                    Spacer()
                }
                .padding(.top, 50)
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Text("Loyalty")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            code = StorageManager.shared.getUser().code
        }
    }
    
    private var qrCodeView: some View {
        Rectangle()
            .frame(width: 200, height: 200)
            .cornerRadius(12)
            .shadow(color: .lightBlue, radius: 55)
            .foregroundColor(.white)
            .overlay {
                Image("qr")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
            }
    }
    
    private var codeView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Code:")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .light, design: .monospaced))
            
            Text(code)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .bold, design: .default))
        }
    }
    
    private var rankView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Rank:")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .light, design: .monospaced))
            
            Text(level)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .bold, design: .default))
        }
    }
}


#Preview {
    UserCodeView()
}
