//
//  WIndow.swift
//  Docs
//
//  Created by Regin Maru on 09/05/2024.
//

import Foundation
import SwiftUI

struct Window: Shape {
    var tint: Color = .clear
    var h: CGFloat = 8 // Default value for h
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the rectangle path using h
        path.move(to: CGPoint(x: rect.minX + h, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - h, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - h, y: rect.minY + h))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + h))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - h))
        path.addLine(to: CGPoint(x: rect.maxX - h, y: rect.maxY - h))
        path.addLine(to: CGPoint(x: rect.maxX - h, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + h, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + h, y: rect.maxY - h))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - h))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + h))
        path.addLine(to: CGPoint(x: rect.minX + h, y: rect.minY + h))
        path.addLine(to: CGPoint(x: rect.minX + h, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}


struct WindowView<Content: View>: View {
    @State var childSize: CGSize
    var tint: Color = Color.clear
    var shadow: Bool = true
    var lineWidth: CGFloat = 2.0
    let content: () -> Content
    
    @Environment(\.colorScheme) var mode: ColorScheme
    var body: some View {
        ZStack {
            Group {
                if tint == .clear {
                    Window().stroke(Color(uiColor: .systemGray6) , lineWidth: lineWidth)
                } else {
                    Window().fill(tint)
                }
            }
            applyShadowIfNeeded(content: content(), shadow: shadow)
                .padding()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
        }
        .onPreferenceChange(SizePreferenceKey.self) { newSize in
            self.childSize = newSize
        }
        .frame(width: childSize.width, height: childSize.height)
    }
}
struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
@ViewBuilder
func applyShadowIfNeeded<Content: View>(content: Content, shadow: Bool) -> some View {
    if shadow {
        content.addShadow()
    } else {
        content
    }
}
