//
//  PinPopover.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct PinPopover: Shape {
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(0)
    
    var isPin: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if isPin {
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                          control1: CGPoint(x: rect.midX, y: rect.maxY),
                          control2: CGPoint(x: rect.minX, y: rect.midY + rect.height / 4))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          control1: CGPoint(x: rect.maxX, y: rect.midY + rect.height / 4),
                          control2: CGPoint(x: rect.midX, y: rect.maxY))
        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + 10))
            path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        return path
    }
}
