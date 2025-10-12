//
//  SplashViewModel.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation

class SplashViewModel: ObservableObject {
    private weak var navigator: NavigationProtocol?

    init(navigator: NavigationProtocol?) {
        self.navigator = navigator
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.navigateToHome()
        }
    }
}

// MARK: Navigation methods
extension SplashViewModel {
    private func navigateToHome() {
        navigator?.push(.home)
    }
}
