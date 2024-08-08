//
//  GamingNewsCellView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//


import SwiftUI

struct GamingNewsCellView: View {
    var image: String
    var header: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let url = URL(string: image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenSize().width - 50, height: 250)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .controlSize(.large)
                        .colorMultiply(.white)
                        .frame(width: screenSize().width - 50, height: 250)
                }
            }
            
            Text(header)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.leading)
                .frame(width: screenSize().width - 50, alignment: .leading)
        }
        .padding(10)
        .background(TransparentCardView(colors: [.lightBlue, .lightBlue, .lightBlue]))
        .cornerRadius(12)
    }
}


#Preview {
    GamingNewsCellView(image: "https://i.ibb.co/Z1r0JCs/3-jpg.png", header: "Resident Evil 7 and Resident Evil 2 Remake Coming to Apple Devices")
        .preferredColorScheme(.dark)
}
