//
//  Modifiers.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct NavBarBackground: ViewModifier {
        
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarBackground(.hidden, for: .navigationBar)
        } else {
            content
        }
    }
}

