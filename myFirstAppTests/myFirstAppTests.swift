//
//  myFirstAppTests.swift
//  myFirstAppTests
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 HBSIS. All rights reserved.
//

import XCTest
@testable import myFirstApp

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    // Confirma que o nome do bar tenha pelo menos 1 caract
    // E o rating seja maior que 0.
    
    func testBarNameSize() {
        
        let barDoZe = Bar.init(name: "Bar do Zé", rating: 1, endereco: "Rua Paraiba", telefone: "47991939632")
        XCTAssertNotNil(barDoZe)
        
        let barDoTiao = Bar.init(name: "Bar do Tião", rating: -1, endereco: "", telefone: "4234")
        XCTAssertNotNil(barDoTiao)
        
        let emptyActivity = Bar.init(name: "", rating: 1, endereco: "Rua Do Zezin", telefone: "47992869059")
        XCTAssertNotNil(emptyActivity)
        
        let emptyActivityRating = Bar.init(name: "", rating: -2, endereco: "Rua São Paulo", telefone: "47")
        XCTAssertNotNil(emptyActivityRating)
        
        let largeRatingMeal = Bar.init(name: "Large", rating: 6, endereco: "Rua muito grande", telefone: "47992869059")
        XCTAssertNil(largeRatingMeal)
        
    }
    
}
