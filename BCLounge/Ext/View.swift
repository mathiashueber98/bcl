//
//  View.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//


import SwiftUI


extension View {
    func glow(_ color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
    
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
    
    func hideScrollIndicator() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollIndicators(.hidden)
        } else {
            return self
        }
    }
    
    func scrollContentBackgroundHidden() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
        } else {
            return self
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

//corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
