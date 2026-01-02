//
//  ContentView.swift
//  CustomProgressView
//
//  Created by Alex Nagy on 02.01.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomProgressView()
            .controlSize(.large)
            .tint(.red)
    }
}

#Preview {
    ContentView()
}
