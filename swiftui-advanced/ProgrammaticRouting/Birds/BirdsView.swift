//
//  BirdsView.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

struct BirdsView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.birdRoutes) {
            Button(action: {
                router.birdRoutes.append(.detail(.tempData))
            }, label: {
                Text("go to BirdsDetailView")
            })
            .navigationDestination(for: BirdsRoute.self) { route in
                switch route {
                case .home:
                    BirdsView()
                case .detail(let bird):
                    BirdsDetailView(bird: bird)
                case .photo(let bird):
                    BirdsPhotoView(bird: bird)
                }
            }
        }
    }
}

#Preview {
    BirdsView()
        .environmentObject(Router.shared)
}
