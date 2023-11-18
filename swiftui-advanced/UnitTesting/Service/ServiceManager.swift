//
//  ServiceManager.swift
//  swiftui-advanced
//
//  Created by kai on 11/18/23.
//

import Foundation

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
    
    private(set) lazy var dataService: DataServiceProtocol = DataService()
}
