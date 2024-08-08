//
//  DragableLogo.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct DragableLogo: View {
    @State private var translation: CGSize = .zero
    @State private var isDragging = false
    
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .scaleEffect(0.9)
            .rotation3DEffect(
                .degrees(isDragging ? 10 : 0),
                axis: (x: -translation.height, y: translation.width, z: 0)
            )
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
                isDragging = true
            }
            .onEnded { _ in
                withAnimation {
                    translation = .zero
                    isDragging = false
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DragableLogo(image: "logo")
    }
}
