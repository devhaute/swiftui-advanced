//
//  DataServiceTests.swift
//  swiftui-advancedTests
//
//  Created by kai on 11/18/23.
//

import XCTest
@testable import swiftui_advanced
import Combine

final class DataServiceTests: XCTestCase {
    private var dataService: DataServiceProtocol?
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        dataService = ServiceManager.shared.dataService
    }

    override func tearDownWithError() throws {
        dataService = nil
        cancellables.removeAll()
    }
    
    func test_DataService_downloadItemsWithAsync_doesReturnValue() {
        // Given
        guard let dataService else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "Aync 함수 리턴")
        
        // When
        Task {
            let result = try await dataService.downloadItemsWithAsync()
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func test_DataService_downloadItemsWithCombine_doesReturnValue() {
        // Given
        guard let dataService else {
            XCTFail()
            return
        }
        var items: [String]?
        let expectation = XCTestExpectation()
        
        // When
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                    break
                case .failure:
                    XCTFail()
                    break
                }
            } receiveValue: { result in
                items = result
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(items)
    }
}
