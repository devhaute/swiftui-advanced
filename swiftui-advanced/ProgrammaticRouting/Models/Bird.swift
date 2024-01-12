//
//  Bird.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import Foundation

struct Bird: Identifiable {
    var id = UUID().uuidString
    let name: String
    let photoURLString: String
}

extension Bird {
    static let tempData = Bird(name: "Sparrow", photoURLString: "url")
}
