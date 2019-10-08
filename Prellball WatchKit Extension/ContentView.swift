//
//  ContentView.swift
//  Prellball WatchKit Extension
//
//  Created by jb on 07.10.19.
//  Copyright © 2019 Jeremy Boy. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var viewModel: PrellViewModel = PrellViewModel()

    var body: some View {
        ScrollView {
            HStack {
                competitorView(for: .home)
                competitorView(for: .visitor)
            }
            Button("Reset") { self.viewModel.reset() }
            Button("Vorlesen") { self.viewModel.read() }
        }
    }

    private func competitorView(for c: Competitor) -> CompetitorView {
        return CompetitorView(text: viewModel.value(for: c),
                              increment: { self.viewModel.increment(for: c)},
                              decrement: { self.viewModel.decrement(for: c)})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CompetitorView: View {

    let text: String
    let increment: () -> Void
    let decrement: () -> Void

    var body: some View {
        return VStack {
            Text(text)
            Button("+", action: increment)
            Button("-", action: decrement)
        }
    }
}
