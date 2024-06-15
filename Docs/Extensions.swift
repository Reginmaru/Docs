//
//  Extensions.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

extension Image {
    func doc() -> some View {
        self.resizable()
            .scaledToFit()
    }
    
    func doc(width: CGFloat, height: CGFloat) -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: width, height: height)
    }
    
    func docBullet() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 4, height: 4)
            .padding(.top, 8)
    }
}

extension View {
    func hide(hide: Bool) -> AnyView {
        if(hide) {
            return AnyView(self.offset(x: -2000, y: -2000))
        }
        return AnyView(self)
    }
    
    func addShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.2), radius: 2, x:2, y: 2)
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension Text {
    func doc() -> AnyView {
        return AnyView(
            self.font(Font.custom("Silkscreen-Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading).padding([.bottom],5)
                .padding([.leading, .trailing], 20)
        )
    }
    
    func docThin() -> AnyView {
        return AnyView(
            self.font(Font.custom("Silkscreen-Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 20)
        )
    }
    
    func docBold() -> AnyView {
        return AnyView (
        self.font(Font.custom("Silkscreen-Bold", size:14))
            .padding([.leading, .trailing], 20)
        )
    }
    
    func docBoldTitle2() -> AnyView {
        return AnyView (
        self.font(Font.custom("Silkscreen-Bold", size:16))
            .padding([.leading, .trailing], 20)
        )
    }
    
    func docBoldTitle() -> AnyView {
        return AnyView (
        self.font(Font.custom("Silkscreen-Bold", size:20))
            .padding([.leading, .trailing], 20)
        )
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    init(hexString: String, alpha: Double = 1.0) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
