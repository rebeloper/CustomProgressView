//
//  CustomProgressView.swift
//  CustomProgressView
//
//  Created by Alex Nagy on 02.01.2026.
//

import SwiftUI

struct CustomProgressView: View {
    @Environment(\.controlSize) private var controlSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let cycleDuration: Double = 0.9

    private let segmentCount = 8
    // Controls the hollow center size (as a fraction of overall size)
    private var innerGapFraction: CGFloat { 0.5 }

    private var size: CGFloat {
        switch controlSize {
        case .mini: return 14
        case .small: return 18
        case .regular: return 22
        case .large: return 28
        case .extraLarge: return 34
        @unknown default: return 22
        }
    }

    private var lineWidth: CGFloat {
        switch controlSize {
        case .mini: return 2
        case .small: return 2.8
        case .regular: return 3.4
        case .large: return 4
        case .extraLarge: return 5
        @unknown default: return 3.4
        }
    }

    var body: some View {
        TimelineView(.animation) { context in
            // Compute a normalized phase 0..1 based on time
            let now = context.date.timeIntervalSinceReferenceDate
            let phase = now.truncatingRemainder(dividingBy: cycleDuration) / cycleDuration

            ZStack {
                ForEach(0..<segmentCount, id: \.self) { index in
                    // Compute geometry per segment to ensure a hollow center
                    let outerRadius = size / 2
                    let capsuleLength = size * 0.40 // longer segments; still clear of the inner gap
                    let innerRadius = max(outerRadius * innerGapFraction, 0)
                    let radialOffset = -(innerRadius + capsuleLength / 2)
                    let baseOpacity = 0.45

                    Capsule()
                        .fill(.tint)
                        .opacity(opacity(for: index, phase: phase) * baseOpacity)
                        .frame(width: lineWidth, height: capsuleLength)
                        .offset(y: radialOffset)
                        .rotationEffect(.degrees(Double(index) / Double(segmentCount) * 360))
                }
            }
            .frame(width: size, height: size)
            .accessibilityLabel("Progress")
            .accessibilityValue("In progress")
        }
    }

    private func opacity(for index: Int, phase: Double) -> Double {
        // If reduce motion is on, show static tail like before
        if reduceMotion {
            return Double(index + 1) / Double(segmentCount)
        }
        // Animate a bright head that moves around the circle by phase, with trailing fade
        // Map phase (0..1) to a head position in segment space
        let head = phase * Double(segmentCount)
        // Compute distance from head to this index in circular space
        let distance = circularDistance(from: Double(index), to: head, modulo: Double(segmentCount))
        // Convert distance to opacity: 1 at head, fading to ~0.2 over 3 segments
        let maxTrail = 3.0
        let t = max(0, 1 - distance / maxTrail)
        let minOpacity = 0.2
        let value = minOpacity + (1 - minOpacity) * t
        return value
    }

    private func circularDistance(from a: Double, to b: Double, modulo m: Double) -> Double {
        let raw = abs(a - b).truncatingRemainder(dividingBy: m)
        return min(raw, m - raw)
    }
}

