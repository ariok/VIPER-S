import XCTest

class ItemsAddDirectorTests: XCTestCase {
    
    // MARK: - Spies
    
    class DataManagerSpy: ItemsAdd_ManageData{
       
        var addedItem: Item? = nil
        
        func add(item:Item){addedItem = item}
    }
    
    class UISpy: ItemsAdd_DisplayUI{

        var isLoading:Bool = false
        var errorIsPresented:Bool = false
        var successIsPresented:Bool = false
        
        func toggle(loading:Bool){ isLoading = loading }
        func displayError(){ errorIsPresented = true }
        func displaySuccess(){ successIsPresented = true }
    }
    
    class NavigatorSpy: ItemsAdd_Navigate{
        
        var goingBack: Bool = false
        
        func goBack(){ goingBack = true }
    }
    
    // MARK: - Tests setup
    
    var director: ItemsAddDirector!
    var navigator: NavigatorSpy!
    var dataManager: DataManagerSpy!
    var ui: UISpy!
    
    override func setUp() {
        super.setUp()
        
        director = ItemsAddDirector()
        ui = UISpy()
        navigator = NavigatorSpy()
        dataManager = DataManagerSpy()
        
        director.ui = ui
        director.navigator = navigator
        director.dataManager = dataManager
    }
    
    // MARK: - Test director
    
    // MARK: - Test UI events handling

    func test_onSaveItem(){
        
        // Given
        let name = "Item Name"
        let enabled = true
        
        // When 
        director.onSaveItem(name: name, enabled: enabled)
        
        // Then
        if let addedItem = dataManager.addedItem {
            XCTAssertEqual(addedItem.name, name)
            XCTAssertEqual(addedItem.enabled, enabled)
        }else {
            XCTFail("Item not added")
        }

    }
    
    // MARK: - Test Presenting data
    
    func test_presentSuccess(){
        
        // When
        director.presentSuccess()
        
        // Then
        XCTAssertTrue(navigator.goingBack)
    }
    
    func test_presentError(){
        
        // Given
        ui.isLoading = true
        
        // When
        director.presentError()
        
        // Then
        XCTAssertFalse(ui.isLoading)
        XCTAssertTrue(ui.errorIsPresented)
    }

    
}
