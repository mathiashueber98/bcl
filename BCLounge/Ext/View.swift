//
//  View.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//


import SwiftUI


extension View {
    // Adds a glow effect to the view
    func glow(_ color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
    
    // Retrieves the screen size
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first else {
            return .zero
        }
        return window.bounds.size
    }
    
    // Hides the scroll indicators
    func hideScrollIndicator() -> some View {
        if #available(iOS 16.0, *) {
            return AnyView(self.scrollIndicators(.hidden))
        } else {
            return AnyView(self)
        }
    }
    
    // Hides the scroll content background
    func scrollContentBackgroundHidden() -> some View {
        if #available(iOS 16.0, *) {
            return AnyView(self.scrollContentBackground(.hidden))
        } else {
            return AnyView(self)
        }
    }
    
    // Adds a placeholder view
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    // Applies rounded corners to specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
