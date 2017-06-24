import XCTest

class ItemsDetailsNavigatorTests: XCTestCase {
    
    func test_makeModule(){
        
        // Given
        let item = Item(name: "one", enabled: true, date: Date(timeIntervalSince1970: 200))
        let module = ItemsDetailsNavigator.makeModule(with: item)
        
        // Then
        
        guard let director = module.eventsHandler as? ItemsDetailsDirector else{
            XCTFail("No director defined")
            return
        }
        
        guard let _ = director.ui as? ItemsDetailsScene else{
            XCTFail("no scene defined")
            return
        }
        
        XCTAssertEqual(director.item.name, item.name)
        
    }
    
}

