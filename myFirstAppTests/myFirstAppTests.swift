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
        
        let barDoZe = Bar.init(name: "Bar do Zé", rating: 1, endereco: "Rua Paraiba", telefone: "47991939632", photo: nil)
        XCTAssertNotNil(barDoZe)
    }
}
