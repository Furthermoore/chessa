//
//  ContentView.swift
//  Chessa
//
//  Created by Dan Moore on 11/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CheckerboardView(viewModel: CheckerboardViewModel.newWithStandardBoard())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
