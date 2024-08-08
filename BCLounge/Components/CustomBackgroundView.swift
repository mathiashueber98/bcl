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
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            GeometryReader { proxy in
                let size = proxy.size
                
                Color.softBlue
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                ForEach(backgroundCircles(size: size), id: \.id) { circle in
                    Circle()
                        .fill(circle.color)
                        .padding(circle.padding)
                        .blur(radius: circle.blur)
                        .offset(x: circle.offsetX, y: circle.offsetY)
                }
            }
        }
    }
    
    private func backgroundCircles(size: CGSize) -> [CircleProperties] {
        return [
            CircleProperties(color: .lightPink, padding: 50, blur: 120, offsetX: -size.width / 1.8, offsetY: -size.height / 5),
            CircleProperties(color: .lightPink, padding: 50, blur: 150, offsetX: size.width / 1.8, offsetY: -size.height / 2),
            CircleProperties(color: .softBlue, padding: 50, blur: 90, offsetX: size.width / 1.8, offsetY: size.height / 2),
            CircleProperties(color: .softBlue, padding: 100, blur: 110, offsetX: size.width / 1.8, offsetY: 550)
        ]
    }
    
    private struct CircleProperties {
        let id = UUID()
        let color: Color
        let padding: CGFloat
        let blur: CGFloat
        let offsetX: CGFloat
        let offsetY: CGFloat
    }
}


#Preview {
    CustomBackgroundView()
}
