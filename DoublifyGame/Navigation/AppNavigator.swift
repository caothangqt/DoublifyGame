//
//  AppNavigator.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//
import Foundation
import SwiftUI

struct AppNavigator: View {
    @StateObject private var coordinator = NavigationCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SplashView(splashViewModel: SplashViewModel(navigator: coordinator)).navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .splash:
                    SplashView(splashViewModel: SplashViewModel(navigator: coordinator))
                case .home:
                    HomeView(homeViewModel: HomeViewModel(navigator: coordinator))
                case .setting:
                    SettingView()
                case .inGame:
                    InGameView(inGameViewModel: InGameViewModel(navigator: coordinator))
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .environmentObject(coordinator)
    }
}
