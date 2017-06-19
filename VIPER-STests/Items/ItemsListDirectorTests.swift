import XCTest

class ItemsListDirectorTests: XCTestCase {
    
    // MARK: - Spies
    
    class DataManagerSpy: ItemsList_ManageData{
        
        var fetched: Bool = false
        var deleted: Bool = false

        func fetchItems(){ fetched = true }
        func deleteAllItems(){ deleted = true }
    }
    
    class UISpy: ItemsList_DisplayUI{
        
        var isLoading:Bool = false
        var presentedItems:[ItemUI] = []
        var errorIsPresented:Bool = false
        var successIsPresented:Bool = false
        
        func toggle(loading:Bool){ isLoading = loading }
        func display(items: [ItemUI]){ presentedItems = items }
        func displayError(){ errorIsPresented = true }
        func displaySuccess(){ successIsPresented = true }
    }
    
    class NavigatorSpy: ItemsList_Navigate{
        
        var selectedItem: Item? = nil
        var goingToAddItem: Bool = false
        var goingBack: Bool = false
        
        func gotoDetail(`for` item:Item){ selectedItem = item }
        func gotoAddItem(with delegate:ItemsAdd_Delegate?){ goingToAddItem = true }
        func goBack(){ goingBack = true }
    }
    
    
    
    // MARK: - Tests setup
    
    var director: ItemsListDirector!
    var navigator: NavigatorSpy!
    var dataManager: DataManagerSpy!
    var ui: UISpy!
    
    override func setUp() {
        super.setUp()
        
        director = ItemsListDirector()
        ui = UISpy()
        navigator = NavigatorSpy()
        dataManager = DataManagerSpy()
        
        director.ui = ui
        director.navigator = navigator
        director.dataManager = dataManager
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

    // MARK: - Test director
    
    func test_currentItemsAreConvertedToItemsUI(){
        
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        let item_two = Item(name: "one", enabled: false, date: Date())
        
        director.items = [item_one, item_two]
        
        // Then 
        XCTAssertTrue(director.itemsUI.count == director.items.count)
        XCTAssertEqual(director.items[0].name, director.itemsUI[0].name)
        XCTAssertEqual(director.itemsUI[0].color, UIColor.darkGray)
        XCTAssertEqual(dateFormat(date: director.items[0].date), director.itemsUI[0].date)

    }
    
    // MARK: - Test UI events handling 
    
    func test_onUIReady(){
        
        // When
        director.onUIReady()
        
        // Then 
        XCTAssertTrue(ui.isLoading)
        XCTAssertTrue(dataManager.fetched)
    }
    
    func test_onDeleteAll(){
        
        // When 
        director.onDeleteAll()
        
        // Then 
        XCTAssertTrue(ui.isLoading)
        XCTAssertTrue(dataManager.deleted)
    }
    
    func test_onItemSelected(){
        
        // Given 
        let item_one = Item(name: "one", enabled: false, date: Date())
        let item_two = Item(name: "one", enabled: false, date: Date())

        director.items = [item_one, item_two]
        
        // When 
        director.onItemSelected(index: 1)
        
        // Then 
        XCTAssertEqual(item_two.name, navigator.selectedItem?.name)
    }
    
    func test_onAddItem(){
        
        // When 
        director.onAddItem()
        
        // Then 
        XCTAssertTrue(navigator.goingToAddItem)
    }
    
    
    // MARK: - Test Presenting data

    func test_presentItems(){
        
        // Given
        let item_one = Item(name: "one", enabled: false, date: Date())
        let item_two = Item(name: "one", enabled: false, date: Date())
        ui.isLoading = true

        // When
        director.present(items: [item_one, item_two])
        
        // Then
        XCTAssertFalse(ui.isLoading)
        XCTAssertTrue(director.items.count == 2)
        XCTAssertTrue(ui.presentedItems.count == 2)
    }
    
    func test_presentSuccess(){
        
        // Given 
        ui.isLoading = true

        // When
        director.presentSuccess()
        
        // Then 
        XCTAssertFalse(ui.isLoading)
        XCTAssertTrue(ui.successIsPresented)
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
