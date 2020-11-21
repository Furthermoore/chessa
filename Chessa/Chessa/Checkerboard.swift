//
//  Checkerboard.swift
//  Chessa
//
//  Created by Dan Moore on 11/21/20.
//

import SwiftUI

struct GridLayer : Shape {
    
    let rows: Int
    let columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct Checkerboard : View {

    static let rows = 8
    static let columns = 8
    
    let color1: Color
    let color2: Color
    
    static func newStandardBoard() -> Checkerboard {
        var pieces = [Checker]()
        for i in 0 ..< 3 {
            for j in 0 ..< columns {
                let needsBlackChecker = (i % 2 == 0) ? (j % 2 == 0) : ((j + 1) % 2 == 0)
                if needsBlackChecker {
                    pieces.append(Checker(color: .black, row: 7 - i, column: j))
                }
                let needsWhiteChecker = (i % 2 == 0) ? ((j + 1) % 2 == 0) : (j % 2 == 0)
                if needsWhiteChecker {
                    pieces.append(Checker(color: .white, row: i, column: j))
                }
            }
        }
        return Checkerboard(color1: .blue, color2: .green, pieces: pieces)
    }
    
    private init(color1: Color, color2: Color, pieces: [Checker]) {
        self.color1 = color1
        self.color2 = color2
        _pieces = .init(initialValue: pieces)
    }
    
    @State private var pieces: [Checker]
    
    var body: some View {
        ZStack {
            color1
            GridLayer(rows: 8, columns: 8)
                .fill(color2)
            GeometryReader { geometry in
                let checkerWidth = geometry.size.width / CGFloat(Checkerboard.columns)
                let checkerHeight = geometry.size.height / CGFloat(Checkerboard.rows)
                ForEach(pieces, id: \.self) { piece in
                    let xOffset = (checkerWidth * CGFloat(piece.column)) + piece.dragOffset.width
                    let yOffset = (checkerHeight * CGFloat(Checkerboard.rows - 1 - piece.row)) + piece.dragOffset.height
                    piece
                        .frame(width: checkerWidth, height: checkerHeight, alignment: Alignment.center)
                        .offset(CGSize(width: xOffset,
                                       height: yOffset))
                }
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
    
}

struct Checkerboard_Previews: PreviewProvider {
    static var previews: some View {
        Checkerboard.newStandardBoard()
    }
}
