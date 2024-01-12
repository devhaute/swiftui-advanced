//
//  BirdsDetailView.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

struct BirdsDetailView: View {
    @EnvironmentObject private var router: Router
    let bird: Bird
    
    var body: some View {
        Button("\(bird.name) 사진보기") {
            router.birdRoutes.append(.photo(bird))
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(bird.name)
    }
}

#Preview {
    BirdsDetailView(bird: .tempData)
}
