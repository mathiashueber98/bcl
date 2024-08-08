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
    
    @State private var currentTab = "Home"
    @State private var isTabBarShown = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                HomeView { toggleTabBar() }
                    .tag("Home")
                
                LocationListView()
                    .tag("Clubs")
                
                UserCodeView()
                    .tag("QR")
                
                ServiceView { toggleTabBar() }
                    .tag("Service")
            }
            
            if isTabBarShown {
                tabBar
                    .padding(.horizontal, 25)
                    .padding(.bottom, screenSize().height > 736 ? -10 : 0)
                    
            }
        }
        .onAppear {
            DataManager.shared.createInitialData()
        }
    }
    
    private var tabBar: some View {
        HStack(spacing: 0) {
            TabButton(title: "Home", image: "house", selected: $currentTab)
            Spacer()
            TabButton(title: "Clubs", image: "gamecontroller", selected: $currentTab)
            Spacer()
            TabButton(title: "QR", image: "qrcode", selected: $currentTab)
            Spacer()
            TabButton(title: "Service", image: "wrench.adjustable", selected: $currentTab)
        }
    }
    
    private func toggleTabBar() {
        isTabBarShown.toggle()
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
        Button(action: selectTab) {
            VStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                
                if isSelected {
                    Text(title)
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .padding(.horizontal)
            .background(
                Rectangle()
                    .fill(Color.white.opacity(isSelected ? 0.08 : 0))
                    .frame(width: 100)
                    .cornerRadius(18)
            )
        }
    }
    
    private var isSelected: Bool {
        selected == title
    }
    
    private func selectTab() {
        withAnimation(.spring) {
            selected = title
        }
    }
}
