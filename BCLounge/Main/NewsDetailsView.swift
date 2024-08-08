//
//  NewsDetailsView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

struct NewsDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var news: GamingNews
    var completion: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        if let url = URL(string: news.image) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: screenSize().width, height: 350)
                                    .clipped()
                                    .cornerRadius(12)
                            } placeholder: {
                                ProgressView()
                                    .controlSize(.large)
                                    .colorMultiply(.white)
                                    .frame(width: screenSize().width - 40, height: 250)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(news.header)
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .bold))
                            
                            Text(news.body)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                        .padding()
                        .background(Color.darkBlue.cornerRadius(12))
                        .offset(y: -30)
                    }
                    .padding(.horizontal)
                }
                .hideScrollIndicator()
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        completion()
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .frame(width: screenSize().width, alignment: .leading)
                }
            }
        }
        .onAppear(perform: completion)
    }
}


#Preview {
    NewsDetailsView(news: .MOCK){}
}
