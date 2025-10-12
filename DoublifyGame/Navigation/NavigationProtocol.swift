//
//  NavigationProtocol.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//
import Foundation

protocol NavigationProtocol: AnyObject {
    func push(_ route: AppRoute)
    func pop()
    func popToRoot()
}
