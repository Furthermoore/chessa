//
//  Location.swift
//  Chessa
//
//  Created by Dan Moore on 11/22/20.
//

import Foundation

enum File : Int, CaseIterable {
    case A, B, C, D, E, F, G, H
}

enum Rank: Int, CaseIterable {
    case one, two, three, four, five, six, seven, eight
}

struct Location {
    let file: File
    let rank: Rank
}

