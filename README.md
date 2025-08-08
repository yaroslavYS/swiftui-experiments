-----

# SwiftUI Shimmer Skeleton

A lightweight, customizable, and dependency-free solution for creating shimmering skeleton views in SwiftUI. This implementation provides a flexible alternative to the standard `.redacted` modifier and avoids the overhead of external libraries.

## Overview


https://github.com/user-attachments/assets/a9879d3e-107f-4445-a4c1-8e984f25712a


When building applications, providing users with a clear loading state is crucial for a good user experience. The standard `.redacted(reason: .placeholder)` modifier in SwiftUI is a quick solution, but it lacks visual appeal and customization options—it offers no shimmer animation and limited shape control. On the other hand, third-party libraries can add unnecessary dependencies and overhead to a project.

This repository offers a custom `.skeleton()` view modifier that is both powerful and easy to integrate, allowing you to create beautiful, animated loading placeholders that match your app's design.

-----

## Features

  - **🎨 Highly Customizable:** Use any `Shape` (like `Circle`, `Rectangle`, or a custom path) for your skeleton views.
  - **✨ Shimmer Animation:** A clean, built-in shimmer effect to indicate activity.
  - **⚖️ Lightweight:** A single, simple `View` extension with no external dependencies.
  - **🔌 Plug and Play:** Simply add the Swift file to your project to get started.

-----

## Usage

To apply the skeleton effect, use the `.skeleton()` modifier on any `View`. The effect is driven by a boolean flag, which you would typically bind to your data loading state.

```swift
import SwiftUI

struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Example 1: Skeleton with a default rounded rectangle shape
            Text("This is a line of text.")
                .font(.title)
                .skeleton(isLoading: isLoading)

            // Example 2: Skeleton with a custom Circle shape
            HStack(spacing: 12) {
                Circle()
                    .frame(width: 50, height: 50)
                    .skeleton(Circle(), isLoading: isLoading)

                Text("Username")
                    .skeleton(isLoading: isLoading)
            }

            Button(isLoading ? "Loading..." : "Reload") {
                isLoading.toggle()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
        .onAppear {
            // Simulate network request
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isLoading = false
            }
        }
    }
}
```

-----

## Implementation

The core logic is encapsulated in a `View` extension and a custom `ViewModifier`.

### The `.skeleton()` Modifier

This extension provides the main API. It checks the `isLoading` state. If `false`, it returns the original view. If `true`, it renders a placeholder shape with the shimmer effect.

```swift
extension View {
    func skeleton<S: Shape>(with shape: S = RoundedRectangle(cornerRadius: 8) as! S, isLoading: Bool) -> some View {
        if isLoading {
            return AnyView(
                self
                    .opacity(0)
                    .overlay(
                        shape
                            .fill(Color.gray.opacity(0.35))
                            .modifier(ShimmeringModifier())
                    )
            )
        } else {
            return AnyView(self)
        }
    }
}
```

### Shimmer Animation

The shimmer effect is achieved using a `TimelineView` to drive a continuous animation. A `LinearGradient` is masked onto the content and animated across the view to create the moving highlight.

```swift
struct ShimmeringModifier: ViewModifier {
    func body(content: Content) -> some View {
        TimelineView(.animation) { timeline in
            let phase = CGFloat(timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 1))
            content.modifier(AnimatedMask(phase: phase))
        }
    }
}

struct AnimatedMask: AnimatableModifier {
    var phase: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func body(content: Content) -> some View {
        content.mask(GradientMask(phase: phase).scaleEffect(3))
    }
}

struct GradientMask: View {
    let phase: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .black.opacity(0.1), location: phase),
                .init(color: .black.opacity(0.6), location: phase + 0.1),
                .init(color: .black.opacity(0.1), location: phase + 0.2),
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .rotationEffect(.degrees(-45))
            .offset(x: -geo.size.width, y: -geo.size.height)
            .frame(width: geo.size.width * 3, height: geo.size.height * 3)
        }
    }
}

```
