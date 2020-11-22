//
//  Checker.swift
//  Chessa
//
//  Created by Dan Moore on 11/21/20.
//

import SwiftUI

struct CheckerView : View {
    
    private let viewModel: CheckerViewModel
    
    init(viewModel: CheckerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Circle().fill(viewModel.color)
    }
    
}

