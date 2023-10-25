//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import Foundation
import Combine

final class AdvancedCombineDataService {
    @Published private(set) var basicPublisher: String = ""
    let currentValueSubject = CurrentValueSubject<String, Never>("")
    let passthroughSubject = PassthroughSubject<String, Never>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let publishedWrapperItems = ["publishedWrapper 1", "publishedWrapper 2", "publishedWrapper 3"]
        let currentValueSubjectItems = ["currentValueSubject 1", "currentValueSubject 2", "currentValueSubject 3"]
        let passthroughSubjectItems = ["passthroughSubjectItems 1", "passthroughSubjectItems 2", "passthroughSubjectItems 3"]
        
        for index in 0..<publishedWrapperItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.basicPublisher = publishedWrapperItems[index]
            }
        }
        
        for index in 0..<currentValueSubjectItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.currentValueSubject.send(currentValueSubjectItems[index])
            }
        }
        
        for index in 0..<passthroughSubjectItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.passthroughSubject.send(passthroughSubjectItems[index])
            }
        }
    }
}
