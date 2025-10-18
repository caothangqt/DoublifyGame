//
//  InGameView.swift
//  DoublifyGame
//
//  Created by Tran Cao Thang on 9/10/25.
//

import SwiftUI

struct InGameView: View {
    @StateObject var inGameViewModel: InGameViewModel
    
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
    }
}

// MARK: - Subviews
extension InGameView {
    @ViewBuilder
    private var titleView: some View {
        HStack {
            self.backButtonView
            
            Spacer()
            
            Text("Total Score: \(inGameViewModel.totalScore)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            self.newGameButtonView
        }
        .padding()
    }
    
    @ViewBuilder
    private var gameBoardView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 176/255, green: 166/255, blue: 150/255))
            
            LazyVGrid(columns: self.columns, spacing: 12) {
                ForEach(0 ..< 16, id: \.self) { index in
                    let row = index/4
                    let col = index % 4
                    let value = self.inGameViewModel.board[row][col]
                    
                    TileView(value: value)
                }
            }
            .padding(12)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal)
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    handleSwipe(translation: value.translation)
                }
        )
    }
    
    @ViewBuilder
    private func TileView(value: Int) -> some View {
        Text(value == 0 ? "" : "\(value)")
            .font(.system(size: 32, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(tileBackgroundColor(for: value))
            .foregroundColor(tileTextColor(for: value))
            .cornerRadius(8)
    }
    
    @ViewBuilder
    private var backButtonView: some View {
        Image(systemName: "arrowshape.backward.fill")
            .renderingMode(.template)
            .foregroundStyle(.brown)
            .scaleEffect(2)
            .onTapGesture {
                self.inGameViewModel.goBack()
            }
    }
    
    @ViewBuilder
    private var newGameButtonView: some View {
        Image(systemName: "repeat.circle")
            .renderingMode(.template)
            .foregroundStyle(.brown)
            .scaleEffect(2)
            .onTapGesture {
                self.inGameViewModel.startNewGame()
            }
    }
}

// MARK: - Private Methods
extension InGameView {
    private func handleSwipe(translation: CGSize) {
        let horizontal = translation.width
        let vertical = translation.height
        
        if abs(horizontal) > abs(vertical) {
            inGameViewModel.move(direction: horizontal > 0 ? .right : .left)
        } else {
            inGameViewModel.move(direction: vertical > 0 ? .down : .up)
        }
    }
    
    private func tileBackgroundColor(for value: Int) -> Color {
        switch value {
        case 0: return Color(.whiteSquare)
        case 2: return Color(.yellowSquare)
        case 4: return Color(.orangeSquare)
        case 8: return Color(.blueSquarecolor)
        case 16: return Color(.redSquare)
        case 32: return Color(.redSquare)
        case 64: return Color(.redSquare)
        default: return Color(.redSquare)
        }
    }
    
    private func tileTextColor(for value: Int) -> Color {
        return value < 8 ? .black : .white
    }
}

// #Preview {
//    InGameView()
// }
