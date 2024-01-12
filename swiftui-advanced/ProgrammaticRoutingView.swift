//
//  ProgrammaticRoutingView.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

struct ProgrammaticRoutingView: View {
    @State private var selectionTab: TabItem = .backyards
    
    var body: some View {
        TabView(selection: $selectionTab) {
            ForEach(TabItem.allCases) { tab in
                tab.destination
                    .tabItem { tab.label }
                    .tag(tab)
            }
        }
    }
}

#Preview {
    ProgrammaticRoutingView()
}
