//
//  Checker.swift
//  Chessa
//
//  Created by Dan Moore on 11/21/20.
//

import SwiftUI

struct Checker : View, Hashable {
    
    static func == (lhs: Checker, rhs: Checker) -> Bool {
        lhs.id == rhs.id
    }
        
    let color: Color
    var row: Int
    var column: Int
    let id: Int
    
    @State var dragOffset = CGSize.zero
    
    init(color: Color, row: Int, column: Int) {
        self.color = color
        self.row = row
        self.column = column
        self.id = (row * Checkerboard.rows) + column
    }
    
    var body: some View {
        Circle().fill(color)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        print("drag changed")
                        dragOffset = gesture.translation
                    }
                    .onEnded { gesture in
                        dragOffset = .zero
                    }
            )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
