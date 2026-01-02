//
//  ContentView.swift
//  CustomProgressView
//
//  Created by Alex Nagy on 02.01.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isEnabled: Bool = true
    
    var body: some View {
        CustomProgressView()
            .controlSize(.regular)
            .tint(.orange)
    }
}

#Preview {
    ContentView()
}
