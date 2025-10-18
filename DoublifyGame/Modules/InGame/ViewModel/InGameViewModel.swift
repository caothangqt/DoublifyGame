//
//  InGameViewModel.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 12/10/25.
//

import Foundation

// Sử dụng typealias để code dễ đọc hơn
typealias Board = [[Int]]

enum SwipeDirection {
    case left, right, up, down
}

class InGameViewModel: ObservableObject {
    private weak var navigator: NavigationProtocol?

    // MARK: - Published Properties

    @Published var board: Board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    @Published var totalScore: Int = 0

    init(navigator: NavigationProtocol) {
        self.navigator = navigator
        
        startNewGame()
    }
}

// MARK: - Game Lifecycle
extension InGameViewModel {
    /// Start a new game, reset the board and numbers.
    func startNewGame() {
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        totalScore = 0
        spawnNewTile()
        spawnNewTile()
    }
}

// MARK: - Game Logic
extension InGameViewModel {
    /// Main function to handle movement. View will call this function.
    func move(direction: SwipeDirection) {
        let oldBoard = board
        var result: (newBoard: Board, score: Int) = (oldBoard, 0)

        switch direction {
        case .left:
            result = slideAndMergeLeft(board)
        case .right:
            let reversed = board.reversedRows()
            let moveResult = slideAndMergeLeft(reversed)
            result = (moveResult.newBoard.reversedRows(), moveResult.score)
        case .up:
            let transposed = board.transposed()
            let moveResult = slideAndMergeLeft(transposed)
            result = (moveResult.newBoard.transposed(), moveResult.score)
        case .down:
            let transposedReversed = board.transposed().reversedRows()
            let moveResult = slideAndMergeLeft(transposedReversed)
            result = (moveResult.newBoard.reversedRows().transposed(), moveResult.score)
        }

        // Only create new squares if the board actually changes
        if result.newBoard != oldBoard {
            board = result.newBoard
            totalScore += result.score
            spawnNewTile()
        }
    }

    /// Create a new cell (2 or 4) at a random empty position.
    private func spawnNewTile() {
        var emptyPositions: [(Int, Int)] = []
        for i in 0..<4 {
            for j in 0..<4 {
                if board[i][j] == 0 {
                    emptyPositions.append((i, j))
                }
            }
        }

        if let pos = emptyPositions.randomElement() {
            // 90% chance of number 2, 10% chance of number 4
            let value = Double.random(in: 0 ... 1) < 0.9 ? 2 : 4
            board[pos.0][pos.1] = value
        }
    }

    // MARK: - Core Move Algorithm

    /// Method for swiping left - Methods for swiping in other directions will be based on this Method
    private func slideAndMergeLeft(_ board: Board) -> (newBoard: Board, score: Int) {
        var newBoard = board
        var currentScore = 0

        for i in 0..<4 {
            // 1. Slide: Remove the 0 cells to squeeze the numbers together
            let filteredRow = newBoard[i].filter { $0 != 0 }

            // 2. Merge: Merge cells with the same value and score points.
            var mergedRow: [Int] = []
            var j = 0
            while j < filteredRow.count {
                if j + 1 < filteredRow.count, filteredRow[j] == filteredRow[j + 1] {
                    let mergedValue = filteredRow[j] * 2
                    mergedRow.append(mergedValue)
                    currentScore += mergedValue // Total Point after merge
                    j += 2
                } else {
                    mergedRow.append(filteredRow[j])
                    j += 1
                }
            }

            // 3. Add 0 at the end to make 4 cells.
            while mergedRow.count < 4 {
                mergedRow.append(0)
            }

            newBoard[i] = mergedRow
        }

        return (newBoard, currentScore)
    }
}

// MARK: Navigate method
extension InGameViewModel {
    func goBack() {
        self.navigator?.pop()
    }
}

// MARK: - Board Transformations
private extension Board {
    /// Chuyển vị ma trận (hàng thành cột và ngược lại).
    func transposed() -> Board {
        var newBoard = self
        for i in 0..<4 {
            for j in 0..<4 {
                newBoard[i][j] = self[j][i]
            }
        }
        return newBoard
    }

    /// Reverse the elements in each row.
    func reversedRows() -> Board {
        return map { $0.reversed() }
    }
}
