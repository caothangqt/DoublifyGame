//
//  HomeNavigationDelegate.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation

protocol HomeNavigationDelegate: AnyObject {
    func didRequestStartGame()
    func didRequestSettings()
}

class HomeCoordinate: HomeNavigationDelegate {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func didRequestStartGame() {
        router.push(toDestination: .inGame)
    }
    
    func didRequestSettings() {
        router.push(toDestination: .setting)
    }
    
    
}
