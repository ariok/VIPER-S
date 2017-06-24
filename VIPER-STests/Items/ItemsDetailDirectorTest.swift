import XCTest

class ItemsDetailDirectorTest: XCTestCase {
    
    // MARK: - Spies
    
    class UISpy: ItemsDetails_DisplayUI{
        
        var name:String? = nil
        var state:String? = nil
        var date:String? = nil
        
        func display(name:String){self.name = name }
        func display(state:String){self.state = state }
        func display(date:String){self.date = date }
    }

    
    // MARK: - Tests setup
    
    var director: ItemsDetailsDirector!
    var ui: UISpy!
    
    override func setUp() {
        super.setUp()
        
        director = ItemsDetailsDirector()
        ui = UISpy()
        director.ui = ui
    }
    
    // MARK: - Test UI events handling

    func test_onUIReady(){
        
        // Given
        let item = Item(name: "One", enabled: true, date: Date(timeIntervalSince1970: 200))
        director.item = item
        
        // When 
        director.onUIReady()
    
        // Then 
        XCTAssertEqual(ui.name, item.name)
        XCTAssertEqual(ui.state, "Enabled")
        XCTAssertEqual(ui.date, dateFormat(date:Date(timeIntervalSince1970: 200)))
    }
}
