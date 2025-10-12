//
//  HomeView.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                homeViewModel.navigateToIngame()
            }, label: {
                Image(systemName: "livephoto.play")
                    .scaleEffect(3)
                    .foregroundStyle(.green)
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}
