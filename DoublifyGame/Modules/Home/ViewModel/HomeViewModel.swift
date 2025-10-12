//
//  HomeViewModel.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    private weak var navigator: NavigationProtocol?
    
    init(navigator: NavigationProtocol?) {
        self.navigator = navigator
    }
    
}

//MARK: Navigation method
extension HomeViewModel {
    func navigateToSetting() {
        navigator?.push(.setting)
    }
    
    func navigateToIngame() {
        navigator?.push(.inGame)
    }
}
