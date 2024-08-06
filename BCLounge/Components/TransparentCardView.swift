//
//  TransparentCardView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//

import SwiftUI

struct TransparentCardView: View{
    
    var colors: [Color]
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
                .background(
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(.init(colors: [
                                
                                colors[0],
                                colors[1],
                                .clear,
                                .clear,
                                colors[2],
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
        }
        
    }
}
