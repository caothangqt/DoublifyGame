//
//  ContentView.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var router = AppRouter()
    @StateObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
