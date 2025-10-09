//
//  HomeViewModel.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    weak var delegate: HomeNavigationDelegate?
    
    init(delegate: HomeNavigationDelegate) {
        self.delegate = delegate
    }
    
    
}

//MARK: Navigation method
extension HomeViewModel {
    func startGameButtonDidTaped() {
        delegate?.didRequestStartGame()
    }
    
    func settingsButtonDidTaped() {
        delegate?.didRequestSettings()
    }
}
