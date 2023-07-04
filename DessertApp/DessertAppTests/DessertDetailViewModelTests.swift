//
//  DessertDetailViewModelTests.swift
//  DessertAppTests
//
//  Created by Jason Pinlac on 7/4/23.
//

import XCTest
@testable import DessertApp

final class DessertDetailViewModelTests: XCTestCase {
    
    var sut: DessertDetailViewModel!
    
    override func setUp() {
        super.setUp()
        let dessertDetail = DessertDetail(id: "1234", name: "Ice Cream With Chocolate Syrup", thumbnailURLString: "https://testurl.com", instructions: "test instructions", ingredient1: "ice cream", ingredient2: "chocolate syrup", ingredient3: nil, ingredient4: nil, ingredient5: nil, ingredient6: nil, ingredient7: nil, ingredient8: nil, ingredient9: nil, ingredient10: nil, ingredient11: nil, ingredient12: nil, ingredient13: nil, ingredient14: nil, ingredient15: nil, ingredient16: nil, ingredient17: nil, ingredient18: nil, ingredient19: nil, ingredient20: nil, measure1: "1 cup", measure2: "2 tablespoons", measure3: nil, measure4: nil, measure5: nil, measure6: nil, measure7: nil, measure8: nil, measure9: nil, measure10: nil, measure11: nil, measure12: nil, measure13: nil, measure14: nil, measure15: nil, measure16: nil, measure17: nil, measure18: nil, measure19: nil, measure20: nil)
        let imageManager = ImageManager()
        sut = DessertDetailViewModel(dessertDetail: dessertDetail, imageManager: imageManager)
        print("setUp")
    }
    
    override func tearDown() {
        print("tearDown")
        sut = nil
        super.tearDown()
    }

    func testInitializer() {
        print("test_initializer")
        let dessertDetail = DessertDetail(id: "1234", name: "Ice Cream With Chocolate Syrup", thumbnailURLString: "https://testurl.com", instructions: "test instructions", ingredient1: "ice cream", ingredient2: "chocolate syrup", ingredient3: nil, ingredient4: nil, ingredient5: nil, ingredient6: nil, ingredient7: nil, ingredient8: nil, ingredient9: nil, ingredient10: nil, ingredient11: nil, ingredient12: nil, ingredient13: nil, ingredient14: nil, ingredient15: nil, ingredient16: nil, ingredient17: nil, ingredient18: nil, ingredient19: nil, ingredient20: nil, measure1: "1 cup", measure2: "2 tablespoons", measure3: nil, measure4: nil, measure5: nil, measure6: nil, measure7: nil, measure8: nil, measure9: nil, measure10: nil, measure11: nil, measure12: nil, measure13: nil, measure14: nil, measure15: nil, measure16: nil, measure17: nil, measure18: nil, measure19: nil, measure20: nil)
        let imageManager = ImageManager()
        let desertDetailViewModel = DessertDetailViewModel(dessertDetail: dessertDetail, imageManager: imageManager)
        XCTAssertNotNil(desertDetailViewModel != nil, "The desertDetailViewModel should not be nil.")
        XCTAssert(desertDetailViewModel.dessertDetail == dessertDetail, "The desertDetail should equal the desertDetail passed in.")
    }
    
    func testDessertDetailName() {
        XCTAssert(sut.dessertDetailName == "Ice Cream With Chocolate Syrup", "The desertDetailViewModel.dessertDetailName did not return the correct value.")
    }
    
    func testDessertDetailThumbnailURLString() {
        XCTAssert(sut.dessertDetailThumbnailURLString == "https://testurl.com", "The desertDetailViewModel.dessertDetailThumbnailURLString did not return the correct value.")
    }
    
    func testDessertDetailInstructions() {
        XCTAssert(sut.dessertDetailInstructions == "test instructions", "The desertDetailViewModel.dessertDetailInstructions did not return the correct value.")
    }
    
    func testDessertDetailActualNumberOfIngredientsAfterInit() {
        XCTAssert(sut.actualIngredients.count == 2, "The desertDetailViewModel.actualIngredients.count after initialization did not return the correct value.")
    }
    
    func testDessertDetailProcessNumberOfActualIngredients() {
        sut.processNumberOfActualIngredients()
        XCTAssert(sut.actualIngredients.count == 4, "The desertDetailViewModel.actualIngredients.count after processingActualIngredients did not return the correct value.")
    }
    

}
