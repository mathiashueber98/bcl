//
//  LoungeCellView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct LoungeCellView: View {
    
    var club: Lounge
    
    var reservation: () -> Void
    var location: () -> Void
    var copy: () -> Void
    
    var body: some View {
        TransparentCardView(colors: [.thinBlue, .thinBlue, .lightPink])
            .frame(width: screenSize().width - 50, height: 400)
            .overlay {
                VStack {
                    // AsyncImage with better frame handling
                    if let url = URL(string: club.image ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: screenSize().width - 55,height: 235) // Adjusted to maintain aspect ratio
                                .clipped()
                                .cornerRadius(25, corners: [.topLeft, .topRight])
                                .padding(.top, 3)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(height: 235)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(club.name ?? "")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                        
                        Text(club.address ?? "")
                            .foregroundColor(.white)
                            .font(.body)
                        
                        Text(club.hours ?? "")
                            .foregroundColor(.white)
                            .font(.body)
                        
                    }
                    .frame(width: screenSize().width - 50, alignment: .leading)
                    .padding(.leading, 40)
                    
                    HStack {
                        actionButton(title: "Reserve", icon: nil, action: reservation)
                        Spacer()
                        actionButton(title: nil, icon: "mappin.circle", action: location)
                        
                        actionButton(title: nil, icon: "phone", action: {
                            copy()
                            copyToClipboard(text: club.phone ?? "")
                        })
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
    }
    
    private func actionButton(title: String?, icon: String?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .frame(width: icon == nil ? 120 : 60, height: 50)
                
                if let title = title {
                    Text(title)
                        .foregroundColor(.black)
                }
                
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                }
            }
        }
    }
    
    private func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}


#Preview {
    LoungeCellView(club: .example) {
        
    } location: {
        
    } copy: {
        
    }
        .preferredColorScheme(.dark)
}
