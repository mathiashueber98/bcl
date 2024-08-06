//
//  CustomBackgroundView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//

import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.darkRed, .darkBlue, .darkBlue],
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            GeometryReader { proxy in
                
                let size = proxy.size
                
                Color.softBlue
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color.lightPink)
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color.lightPink)
                    .padding(50)
                    .blur(radius: 150)
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                
                Circle()
                    .fill(Color.softBlue)
                    .padding(50)
                    .blur(radius: 90)
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                
                Circle()
                    .fill(Color.softBlue)
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: size.width / 1.8, y: 550)
                
            }
        }
    }
}


#Preview {
    CustomBackgroundView()
}
