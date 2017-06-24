import XCTest

class ItemsAddNavigatorTests: XCTestCase {
    
    class ItemsAddDelegate:ItemsAdd_Delegate{
        func itemDidCreate(){}
    }
    
    func test_makeModule(){
        
        // Given
        let module = ItemsAddNavigator.makeModule(with:ItemsAddDelegate())
        
        // Then
        
        guard let director = module.eventsHandler as? ItemsAddDirector else{
            XCTFail("No director defined")
            return
        }
        
        guard let worker = director.dataManager as? ItemsAddWorker else{
            XCTFail("No worker defined")
            return
        }
        
        guard let _ = director.navigator as? ItemsAddNavigator else{
            XCTFail("No navigator defined")
            return
        }
        
        guard let _ = director.ui as? ItemsAddScene else{
            XCTFail("no scene defined")
            return
        }
        
        guard let _ = worker.presenter as? ItemsAddDirector else{
            XCTFail("no presenter defined")
            return
        }
        
    }
    
}
