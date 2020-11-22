//
//  Checkerboard.swift
//  Chessa
//
//  Created by Dan Moore on 11/21/20.
//

import SwiftUI

struct CheckerboardView : View {
        
    @ObservedObject private var viewModel: CheckerboardViewModel
    @State private var dragOffset: (Int, CGSize)?
    
    init(viewModel: CheckerboardViewModel) {
        self.viewModel = viewModel
    }
    
    private func checkerSize(using geometry: GeometryProxy) -> CGSize {
        CGSize(width: geometry.size.width / CGFloat(File.allCases.count),
               height: geometry.size.height / CGFloat(Rank.allCases.count))
    }
        
    var body: some View {
        ZStack {
            self.viewModel.color1
                .zIndex(1) // default z index of 0
            CheckerPattern(rows: 8, columns: 8)
                .fill(self.viewModel.color2)
                .zIndex(2)
            Group {
                GeometryReader { geometry in
                    let checkerSize = self.checkerSize(using: geometry)
                    ForEach(self.viewModel.checkerViewModels, id: \.self) { vm in
                       CheckerView(viewModel: vm)
                            .frame(width: checkerSize.width, height: checkerSize.height, alignment: Alignment.center)
                            .offset(vm.offset(checkerSize: checkerSize, dragOffset: self.dragOffset))
                            .zIndex((self.dragOffset == nil) ? 1 : ((self.dragOffset!.0 == vm.id) ? 2 : 1))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        dragOffset = (vm.id, gesture.translation)
                                    }
                                    .onEnded { gesture in
                                        dragOffset = nil
                                    }
                            )
                    }
                }
            }
            .zIndex(3)
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
    
}

struct Checkerboard_Previews: PreviewProvider {
    static var previews: some View {
        CheckerboardView(viewModel: CheckerboardViewModel.newWithStandardBoard())
    }
}
