//
//  CheckerViewModel.swift
//  Chessa
//
//  Created by Dan Moore on 11/22/20.
//

import Foundation
import SwiftUI

class CheckerViewModel: ObservableObject {
        
    let id: Int
    let color: Color
    let pieceColor: PieceColor
    @Published var location: Location
    
    init(id: Int, pieceColor: PieceColor, location: Location) {
        self.id = id
        switch pieceColor {
        case .white: self.color = .white
        case .black: self.color = .black
        }
        self.pieceColor = pieceColor
        self.location = location
    }
    
    func offset(checkerSize: CGSize, dragOffset: (Int, CGSize)?) -> CGSize {
        var offset = CGSize(width: checkerSize.width * CGFloat(location.file.rawValue), height: checkerSize.height * CGFloat(Rank.allCases.count - 1 - location.rank.rawValue))
        if let (dragId, drag) = dragOffset, dragId == id {
            offset = CGSize(width: offset.width + drag.width, height: offset.height + drag.height)
        }
        return offset
    }
        
}

extension CheckerViewModel : Hashable {
    
    static func == (lhs: CheckerViewModel, rhs: CheckerViewModel) -> Bool {
        lhs.id == rhs.id
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
