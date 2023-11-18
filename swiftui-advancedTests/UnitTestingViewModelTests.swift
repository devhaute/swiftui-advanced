//
//  UnitTestingViewModelTests.swift
//  swiftui-advancedTests
//
//  Created by kai on 11/16/23.
//

import XCTest
@testable import swiftui_advanced
import Combine

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given When Then

final class UnitTestingViewModelTests: XCTestCase {
    var viewModel: UnitTestingView.UnitTestingViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
    }

    func test_UnitTestViewModel_IsPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(viewModel.isPremium)
    }
    
    func test_UnitTestViewModel_IsPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(viewModel.isPremium)
    }
    
    func test_UnitTestViewModel_IsPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(userIsPremium, viewModel.isPremium)
    }
    
    func test_UnitTestViewModel_IsPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(userIsPremium, viewModel.isPremium)
        }
    }
    
    func test_UnitTextViewModel_items_shouldBeEmpty() {
        // Given
        
        // When
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertEqual(viewModel.items.count, 0)
    }
    
    func test_UnitTestingViewModel_items_shouldBeAddItems() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 1...20)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(viewModel.items.isEmpty)
        XCTAssertGreaterThanOrEqual(viewModel.items.count, loopCount)
    }
    
    func test_UnitTestingViewModel_items_shouldNotAddEmptyString() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // When
        viewModel.addItem(item: "")
        
        // Then
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertEqual(viewModel.items.count, 0)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    // 배열에 없는 item을 선택했을 경우
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // When
        viewModel.addItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        let newItem = UUID().uuidString
        
        // When
        viewModel.addItem(item: newItem)
        viewModel.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        let loopCount = 20
        
        // When
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            viewModel.selectItem(item: newItem)
        }
        
        // Then
        XCTAssertEqual(viewModel.items.count, loopCount)
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldBeThrowsError_noData() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(item: "")) { error in
            let resultError = error as? AppError
            XCTAssertEqual(resultError, AppError.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem_stress() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        var tempItemArray = [String]()
        
        // When
        for _ in 0..<20 {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            tempItemArray.append(newItem)
        }

        // Then
        XCTAssertNoThrow(
            try viewModel.saveItem(item: tempItemArray.randomElement() ?? "")
        )
    }
    
    func test_UnitTestingViewModel_downloadItemsWithAsync_shouldReturnItems() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        viewModel.$items
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.downloadItemsWithAsync()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.items.isEmpty)
    }
    
    func test_UnitTestingViewModel_downloadItemsWithCombine_shouldReturnItems() {
        // Given
        guard let viewModel else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        viewModel.$items
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.downloadItemWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.items.isEmpty)
    }
}
