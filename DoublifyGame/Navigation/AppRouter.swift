//
//  AppRouter.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation
import SwiftUI

class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
}

// MARK: Router method
extension AppRouter {
    func push(toDestination: AppRoute) {
        path.append(toDestination)
    }

    func pop(removeCurrentRoute: AppRoute) {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
