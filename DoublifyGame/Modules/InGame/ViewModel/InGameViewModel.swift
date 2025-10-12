//
//  InGameViewModel.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 12/10/25.
//

import Foundation

class InGameViewModel: ObservableObject {
    @Published var matrix4x4 = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ] {
        didSet {
            self.totalScore = self.sumMatrix()
        }
    }
    
    @Published var totalScore = 0
    
    func initializeGame() {
        matrix4x4 = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ]
        spawnNewTile()
        spawnNewTile()
    }
}

extension InGameViewModel {
    func onMove() {
        for i in 0..<matrix4x4.count {
            for k in 0..<matrix4x4[i].count {
                if matrix4x4[i][k] == 0 {
                    matrix4x4[i][k] = Int.random(in: 0 ... 9)
                }
            }
        }
    }

    private func transpose(_ board: [[Int]]) -> [[Int]] {
        var newBoard = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        for i in 0..<4 {
            for j in 0..<4 {
                newBoard[i][j] = board[j][i]
            }
        }
        return newBoard
    }


    private func reverseRows(_ board: [[Int]]) -> [[Int]] {
        return board.map { Array($0.reversed()) }
    }


    func moveLeft(_ board: [[Int]]) -> [[Int]] {
        var newBoard = board.map { row -> [Int] in
            var filtered = row.filter { $0 != 0 } // bỏ 0
            var merged: [Int] = []
            var i = 0

            while i < filtered.count {
                if i + 1 < filtered.count, filtered[i] == filtered[i + 1] {
                    merged.append(filtered[i] * 2)
                    i += 2
                } else {
                    merged.append(filtered[i])
                    i += 1
                }
            }

            while merged.count < 4 {
                merged.append(0)
            }
            return merged
        }
        return newBoard
    }

    func moveRight(_ board: [[Int]]) -> [[Int]] {
        return reverseRows(moveLeft(reverseRows(board)))
    }

    func moveTop(_ board: [[Int]]) -> [[Int]] {
        return transpose(moveLeft(transpose(board)))
    }

    func moveBottom(_ board: [[Int]]) -> [[Int]] {
        return transpose(moveRight(transpose(board)))
    }
    
    func spawnNewTile() {
        var emptyPositions: [(Int, Int)] = []
        for i in 0..<4 {
            for j in 0..<4 {
                if matrix4x4[i][j] == 0 {
                    emptyPositions.append((i, j))
                }
            }
        }
        if let pos = emptyPositions.randomElement() {
            let value = Double.random(in: 0...1) < 0.9 ? 2 : 4
            matrix4x4[pos.0][pos.1] = value
        }
    }

    private func sumMatrix() -> Int {
        var total = 0
        for row in self.matrix4x4 {
            for value in row {
                total += value
            }
        }
        return total
    }
}
