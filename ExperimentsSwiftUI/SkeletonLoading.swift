//
//  SkeletonLoading.swift
//  ExperimentsSwiftUI
//
//  Created by Yaroslav Skorokhid on 08.08.2025.
//
import SwiftUI

extension View {
    func skeleton<S>(_ shape: S? = nil as Rectangle?, isLoading: Bool) -> some View where S: Shape {
        guard isLoading else { return AnyView(self) }

        let shapeView: AnyShape = shape.map(AnyShape.init)
            ?? AnyShape(RoundedRectangle(cornerRadius: 20))

        return AnyView(
            self
                .opacity(0)
                .overlay(
                    shapeView
                        .fill(Color.gray.opacity(0.3))
                        .shimmering()
                )
        )
    }

    func shimmering() -> some View {
        modifier(ShimmeringModifier())
    }
}
