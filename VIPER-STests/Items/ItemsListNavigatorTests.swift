import XCTest

class ItemsListNavigatorTests: XCTestCase {

    func test_makeModule(){
    
        // Given 
        let module = ItemsListNavigator.makeModule()
        
        // Then
        
        guard let director = module.eventsHandler as? ItemsListDirector else{
            XCTFail("No director defined")
            return
        }
        
        guard let worker = director.dataManager as? ItemsListWorker else{
            XCTFail("No worker defined")
            return
        }
        
        guard let _ = director.navigator as? ItemsListNavigator else{
            XCTFail("No navigator defined")
            return
        }
        
        guard let _ = director.ui as? ItemsListScene else{
            XCTFail("no scene defined")
            return
        }
        
        guard let _ = worker.presenter as? ItemsListDirector else{
            XCTFail("no presenter defined")
            return
        }
        
    }
    
}
