//
//  LoungeCellView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct LoungeCellView: View {
    
    var club: Lounge
    
    var reservation: () -> ()
    var location: () -> ()
    var copy: () -> ()
    
    var body: some View {
        TransparentCardView(colors: [.thinBlue,.thinBlue,.lightPink])
            .frame(width: screenSize().width - 50, height: 400)
            .overlay {
                VStack {
                    if let url = URL(string: club.image ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: screenSize().width - 57, height: 250)
                                .clipped()
                                .cornerRadius(25, corners: [.topLeft, .topRight])
                                .padding(.top, 3)
                        } placeholder: {
                            ProgressView()
                                .controlSize(.large)
                                .colorMultiply(.white)
                                .frame(width: screenSize().width - 40, height: 250)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(club.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        Text(club.address ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                        
                        Text(club.hours ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    .frame(width: screenSize().width - 50, alignment: .leading)
                    .padding(.leading, 40)
                    
                    HStack {
                        Button {
                            reservation()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(height: 50)
                                
                                Text("Reserve")
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Button {
                            location()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(width: 60, height: 50)
                                
                                Image(systemName: "mappin.circle")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22))
                            }
                        }
                        
                        Button {
                            copy()
                            copyToClipboard(text: club.phone ?? "")
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(width: 60, height: 50)
                                
                                Image(systemName: "phone")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22))
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
            }
    }
    
    func copyToClipboard(text: String) {
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
