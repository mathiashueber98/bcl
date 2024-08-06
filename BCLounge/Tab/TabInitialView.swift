//
//  TabInitialView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct TabInitialView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var current = "Home"
    @State private var isTabBarShown = true
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $current) {
                
                HomeView() {
                    isTabBarShown.toggle()
                }
                .tag("Home")
                
                LocationListView()
                    .tag("Clubs")
                
                UserCodeView()
                    .tag("QR")
                
                ServiceView() {
                    isTabBarShown.toggle()
                }
                    .tag("Service")
            }
            
            if isTabBarShown {
                
                HStack(spacing: 0) {
                    TabButton(title: "Home", image: "house", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Clubs", image: "gamecontroller", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "QR", image: "qrcode", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Service", image: "wrench.adjustable", selected: $current)
                }
                .padding(.horizontal)
                
                .padding(.horizontal, 25)
                .padding(.bottom, 5)
            }
            
        }
        .onAppear {
            DataManager.shared.createInitialData()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TabInitialView()
}


struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            VStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                
                if selected == title {
                    Text(title)
                    
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .padding(.horizontal)
            .background(
                Rectangle()
                    .fill(Color.white.opacity(selected == title ? 0.08 : 0))
                    .frame(width: 100)
                    .cornerRadius(18)
            )
        }
    }
}
