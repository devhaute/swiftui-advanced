//
//  BackyardsView.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

struct BackyardsView: View {
    var body: some View {
        NavigationStack {
            List(1...10, id: \.self) { index in
                NavigationLink {
                    Text("Backyard Detail")
                } label: {
                    Text("go to detail")
                }
            }
            .listStyle(.plain)
            .padding(.top, 30)
        }
    }
}

#Preview {
    BackyardsView()
}
