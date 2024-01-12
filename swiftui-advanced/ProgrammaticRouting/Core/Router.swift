//
//  Router.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import Foundation

enum PlantRoute: Hashable {
    case home
    case detail
}

enum BirdsRoute {
    case home
    case detail(Bird)
    case photo(Bird)
}

extension BirdsRoute: Hashable {
    private var id: String {
        switch self {
        case .home:
            return "home"
        case .detail:
            return "detail"
        case .photo:
            return "photo"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

class Router: ObservableObject {
    static let shared = Router()
    private init() {}
    
    @Published var birdRoutes: [BirdsRoute] = []
    @Published var plantRoute: [PlantRoute] = []
}
