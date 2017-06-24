import XCTest

class ItemsAddWorkerTests: XCTestCase {
    
    // MARK: - Spies
    
    class PresenterSpy:ItemsAdd_PresentData {

        var expectation:XCTestExpectation? = nil
        var isSuccessPresented = false
        var isErrorPresented = false
        
        func presentSuccess(){ isSuccessPresented = true; expectation?.fulfill(); }
        func presentError(){ isErrorPresented = true; expectation?.fulfill(); }
    }
    
    // MARK: - Tests setup
    
    var worker: ItemsAddWorker!
    var presenter: PresenterSpy!
    
    override func setUp() {
        super.setUp()
        
        worker = ItemsAddWorker()
        presenter = PresenterSpy()
        worker.presenter = presenter
    }

    // MARK : - Test worker
    
    func test_addItemCompleted(){
    
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        let item_two = Item(name: "two", enabled: false, date: Date())
        
        let new_item = Item(name: "three", enabled: true, date: Date(timeIntervalSince1970: 200))
        
        NetworkManager.storedItems = [item_one, item_two]
        NetworkManager.nextCallWillFail = false
        
        let expect = expectation(description: "add")
        presenter.expectation = expect
        
        // When
        worker.add(item: new_item)
        
        // Then
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(NetworkManager.storedItems.count == 3)
        
        if let newStoreItem = NetworkManager.storedItems.last{
            XCTAssertEqual(newStoreItem.name, new_item.name)
            XCTAssertEqual(newStoreItem.enabled, new_item.enabled)
            XCTAssertEqual(newStoreItem.date, Date(timeIntervalSince1970: 200))
            XCTAssertTrue(presenter.isSuccessPresented)

        }else{
            XCTFail()
        }
        
    }
    
    func test_addItemFailed(){
        
        // Given
        let item_one = Item(name: "one", enabled: true, date: Date() )
        let item_two = Item(name: "two", enabled: false, date: Date())
        
        let new_item = Item(name: "three", enabled: true, date: Date(timeIntervalSince1970: 200))
        
        NetworkManager.storedItems = [item_one, item_two]
        NetworkManager.nextCallWillFail = true
        
        let expect = expectation(description: "add")
        presenter.expectation = expect
        
        // When
        worker.add(item: new_item)
        
        // Then
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(NetworkManager.storedItems.count == 2)
        XCTAssertTrue(presenter.isErrorPresented)
        
    }
}
