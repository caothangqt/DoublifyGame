    //
//  AppCoordinator.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation

class AppCoordinator: ObservableObject {
    let router: AppRouter
    
    let homeCoodinator: HomeCoordinate
    
    init(router: AppRouter, homeCoodinator: HomeCoordinate) {
        self.router = router
        self.homeCoodinator = homeCoodinator
    }
}

