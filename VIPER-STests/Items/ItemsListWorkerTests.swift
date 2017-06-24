import XCTest

class ItemsListWorkerTests: XCTestCase {
    
    // MARK: - Spies
    
    class PresenterSpy:ItemsList_PresentData {
        
        var presentedItems:[Item] = []
        var isSuccessPresented = false
        var isErrorPresented = false
        var expectation:XCTestExpectation? = nil
        
        func present(items:[Item]){ presentedItems = items; expectation?.fulfill();}
        func presentSuccess(){ isSuccessPresented = true }
        func presentError(){ isErrorPresented = true }
    }
    
    // MARK: - Tests setup
    
    var worker: ItemsListWorker!
    var presenter: PresenterSpy!
    
    override func setUp() {
        super.setUp()
        
        worker = ItemsListWorker()
        presenter = PresenterSpy()
        worker.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK : - Test worker 
    
    func test_fetchItemsCompleted(){
        
        // Given 
        let item_one = Item(name: "one", enabled: true, date: Date() )
        let item_two = Item(name: "two", enabled: false, date: Date())
        
        NetworkManager.storedItems = [item_one, item_two]
        NetworkManager.nextCallWillFail = false
        
        let expect = expectation(description: "fetch")
        presenter.expectation = expect
        
        // When
        worker.fetchItems()
        
        // Then
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(presenter.presentedItems.count == 2)
        
    }
    
    func test_fetchItemsFailed(){
        
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        let item_two = Item(name: "two", enabled: false, date: Date())
        
        NetworkManager.storedItems = [item_one, item_two]
        NetworkManager.nextCallWillFail = true
        
        // When
        worker.fetchItems()
        
        // Then
        XCTAssertTrue(presenter.presentedItems.count == 0)
        XCTAssertTrue(presenter.isErrorPresented)
        
    }
    
    func test_deleteAllItemsCompleted(){
        
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        // Add a presented item and reset it with test
        presenter.presentedItems = [item_one]
        NetworkManager.nextCallWillFail = false

        // When
        worker.deleteAllItems()
        
        // Then
        XCTAssertTrue(presenter.presentedItems.count == 0)
    }
    
    func test_deleteAllItemsFailed(){
        
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        presenter.presentedItems = [item_one]
        NetworkManager.nextCallWillFail = true
        
        // When
        worker.deleteAllItems()
        
        // Then
        XCTAssertTrue(presenter.presentedItems.count == 1)
    }
    
}
