//
//  UnitTestingViewModelTests.swift
//  swiftui-advancedTests
//
//  Created by kai on 11/16/23.
//

import XCTest
@testable import swiftui_advanced

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given When Then

final class UnitTestingViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func test_UnitTextViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeAddItems() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...20)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(viewModel.dataArray.isEmpty)
        XCTAssertGreaterThanOrEqual(viewModel.dataArray.count, loopCount)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddEmptyString() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        viewModel.addItem(item: "")
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    // 배열에 없는 item을 선택했을 경우
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        viewModel.addItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        let newItem = UUID().uuidString
        
        // When
        viewModel.addItem(item: newItem)
        viewModel.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        let loopCount = 20
        
        // When
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            viewModel.selectItem(item: newItem)
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, loopCount)
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldBeThrowsError_noData() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(item: "")) { error in
            let resultError = error as? DataError
            XCTAssertEqual(resultError, DataError.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem_stress() {
        // Given
        let viewModel = UnitTestingView.UnitTestingViewModel(isPremium: Bool.random())
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
}
