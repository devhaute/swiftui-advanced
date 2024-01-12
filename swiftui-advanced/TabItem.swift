//
//  TabItem.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

enum TabItem: CaseIterable, Identifiable {
    var id: Self { self }
    
    case backyards
    case birds
    case plants
}

extension TabItem {
    @ViewBuilder
    var destination: some View {
        switch self {
        case .backyards:
            BackyardsView()
        case .birds:
            BirdsView()
        case .plants:
            Text("plants")
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .backyards:
            Label(
                title: { Text("Backyards") },
                icon: { Image(systemName: "tree") }
            )
        case .birds:
            Label(
                title: { Text("Birds") },
                icon: { Image(systemName: "bird") }
            )
        case .plants:
            Label(
                title: { Text("Plants") },
                icon: { Image(systemName: "leaf") }
            )
        }
    }
}

typealias TabItems = [TabItem]
