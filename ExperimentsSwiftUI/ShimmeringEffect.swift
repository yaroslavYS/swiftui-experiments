//
//  ShimmeringEffect.swift
//  ExperimentsSwiftUI
//
//  Created by Yaroslav Skorokhid on 08.08.2025.
//
import SwiftUI

struct ShimmeringModifier: ViewModifier {
    func body(content: Content) -> some View {
        TimelineView(.animation) { timeline in
            let phase = CGFloat(timeline.date.timeIntervalSinceReferenceDate
                                .truncatingRemainder(dividingBy: 1))
            content.modifier(AnimatedMask(phase: phase))
        }
    }
}

struct AnimatedMask: AnimatableModifier {
    var phase: CGFloat
    var animatableData: CGFloat { get { phase } set { phase = newValue } }

    func body(content: Content) -> some View {
        content.mask(GradientMask(phase: phase).scaleEffect(3))
    }
}

struct GradientMask: View {
    let phase: CGFloat

    var body: some View {
        GeometryReader { geo in
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .white.opacity(0.1), location: phase),
                .init(color: .white.opacity(0.6), location: phase + 0.1),
                .init(color: .white.opacity(0.1), location: phase + 0.2),
            ]), startPoint: .leading, endPoint: .trailing)
            .rotationEffect(.degrees(-45))
            .offset(x: -geo.size.width, y: -geo.size.height)
            .frame(width: geo.size.width * 3,
                   height: geo.size.height * 3)
        }
    }
}
