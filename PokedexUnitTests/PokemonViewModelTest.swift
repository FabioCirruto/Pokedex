//
//  PokemonViewModelTest.swift
//  PokedexUnitTests
//
//  Created by Fabio Cirruto on 22/05/24.
//

import XCTest
import Factory
@testable import Pokedex

final class PokemonViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownload() async {
        Container.shared.reset()
        let viewModel = Container.shared.pokemonViewModel.resolve()
        
        XCTAssertNotNil(viewModel)
        XCTAssertFalse(viewModel.canDownloadMore)
        
        viewModel.download()
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in
                viewModel.models.count == 20
            }), object: nil
        )
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.models.count, 20)
    }

}
