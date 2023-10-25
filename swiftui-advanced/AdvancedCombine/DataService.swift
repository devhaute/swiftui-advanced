//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import Foundation
import Combine

final class AdvancedCombineDataService {
    let passthroughSubject = PassthroughSubject<Int, Never>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let passthroughSubjectItems = Array(0..<11)
        
        for index in 0..<passthroughSubjectItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.passthroughSubject.send(passthroughSubjectItems[index])
            }
        }
    }
}
