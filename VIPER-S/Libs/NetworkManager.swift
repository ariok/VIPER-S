import Foundation

/**
 THIS CLASS HAS NOTHING TO DO WITH VIPER-S:
 This code simulates network calls adding some delay and miming a generic network flow.
 **/

class NetworkManager{
    
    init() {
        
    }
    
    static var storedItems:[Item] = [Item(name:"Item", enabled:true, date:Date())]
    
    static func getItems(completion:@escaping ([Item], Bool)->Void ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(storedItems, true)
        }
    }
    
    static func add(item:Item, completion:@escaping (Bool)->Void ) {
        
        storedItems.append(item)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(true)
        }
    }
    
    static func flushItems( completion:@escaping (Bool)->Void ){
        
        storedItems = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(true)
        }
    }
}
