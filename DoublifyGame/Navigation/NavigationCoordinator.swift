//
//  NavigationCoordinator.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import Foundation
import SwiftUI

final class NavigationCoordinator: ObservableObject, NavigationProtocol {
    @Published var path = NavigationPath()
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
    }
}
