//
//  DividerView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(width: screenSize().width - 40, height: 1)
            .foregroundColor(.lightBlue.opacity(0.5))
    }
}

#Preview {
    DividerView()
}
