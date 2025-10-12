//
//  SettingView.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import SwiftUI

struct InGameView: View {
    @StateObject var inGameViewModel = InGameViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color(red: 249/255, green: 247/255, blue: 235/255)
                .ignoresSafeArea()

            VStack {
                self.titleView

                Spacer()

                self.gameBoardView

                Spacer()
            }
        }
        .onAppear {
            inGameViewModel.initializeGame()
        }
    }
}

// Title View
extension InGameView {
    @ViewBuilder
    var titleView: some View {
        HStack {
            Text("Total Score: \(inGameViewModel.totalScore)")
        }
    }
}

// Gameboard View
extension InGameView {
    @ViewBuilder
    var gameBoardView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 176/255, green: 166/255, blue: 150/255))
                .aspectRatio(contentMode: .fit)
                .padding()
//                .onTapGesture {
//                    inGameViewModel.matrix4x4 = inGameViewModel.moveLeft(inGameViewModel.matrix4x4)
//                    inGameViewModel.spawnNewTile()
//                }

            LazyVGrid(columns: self.columns, spacing: 8) {
                ForEach(0 ..< 16, id: \.self) { index in
                    let row = index/4
                    let col = index % 4
                    let value = self.inGameViewModel.matrix4x4[row][col]

                    Text(value == 0 ? "" : "\(value)")
                        .frame(width: 60, height: 60)
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(8)
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    let horizontal = value.translation.width
                    let vertical = value.translation.height
                    
                    let oldBoard = inGameViewModel.matrix4x4
                    var newBoard = oldBoard

                    if abs(horizontal) > abs(vertical) {
                        if horizontal > 0 {
                            newBoard = inGameViewModel.moveRight(oldBoard)
                        } else {
                            newBoard = inGameViewModel.moveLeft(oldBoard)
                        }
                    } else {
                        if vertical > 0 {
                            newBoard = inGameViewModel.moveBottom(oldBoard)
                        } else {
                            newBoard = inGameViewModel.moveTop(oldBoard)
                        }
                    }
                    
                    if newBoard != oldBoard {
                        inGameViewModel.matrix4x4 = newBoard
                        inGameViewModel.spawnNewTile()
                    }
                }
        )
    }
}

#Preview {
    InGameView()
}
