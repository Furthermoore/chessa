//
//  CheckerboardViewModel.swift
//  Chessa
//
//  Created by Dan Moore on 11/22/20.
//

import Foundation
import SwiftUI

class CheckerboardViewModel: ObservableObject {
    
    let color1: Color
    let color2: Color
    
    @Published var checkerViewModels: [CheckerViewModel]
    
    static func newWithStandardBoard() -> CheckerboardViewModel {
        var vms = [CheckerViewModel]()
        let generateId: (Int, Int) -> Int = { row, column in (row * 8) + column }
        for i in 0 ..< 3 {
            for j in 0 ..< File.allCases.count {
                let needsBlackChecker = (i % 2 == 0) ? (j % 2 == 0) : ((j + 1) % 2 == 0)
                let needsWhiteChecker = (i % 2 == 0) ? ((j + 1) % 2 == 0) : (j % 2 == 0)
                if needsBlackChecker {
                    let id = generateId(i,j)
                    let location = Location(file: File(rawValue: j)!, rank: Rank(rawValue: Rank.allCases.count - 1 - i)!)
                    let vm = CheckerViewModel(id: id, pieceColor: .black, location: location)
                    vms.append(vm)
                } else if needsWhiteChecker {
                    let id = generateId(i,j)
                    let location = Location(file: File(rawValue: j)!, rank: Rank(rawValue: i)!)
                    let vm = CheckerViewModel(id: id, pieceColor: .white, location: location)
                    vms.append(vm)
                }
            }
        }
        return CheckerboardViewModel(color1: .blue, color2: .green, checkerViewModels: vms)
    }
    
    private init(color1: Color, color2: Color, checkerViewModels: [CheckerViewModel]) {
        self.color1 = color1
        self.color2 = color2
        self.checkerViewModels = checkerViewModels
    }
    
}
