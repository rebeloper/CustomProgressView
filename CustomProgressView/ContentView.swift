//
//  ContentView.swift
//  CustomProgressView
//
//  Created by Alex Nagy on 02.01.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            ProgressView()
            CustomProgressView()
        }
//        .controlSize(.large)
//        .tint(.red)
    }
}

#Preview {
    ContentView()
}
