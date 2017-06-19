import Foundation

class NetworkManager{
    
    init() {}
    
    static var storedItems:[Item] = []
    static var nextCallWillFail: Bool = false
    
    static func getItems(completion:@escaping ([Item], Bool)->Void ) {
        
        if nextCallWillFail{
            completion([], false)
        }else {
            print("STORED \(NetworkManager.storedItems)")
            completion(NetworkManager.storedItems, true)
        }
    }
    
    static func add(item:Item, completion:@escaping (Bool)->Void ) {
        
        if nextCallWillFail {
            completion(false)
        }else{
            storedItems.append(item)
            completion(true)
        }
    }
    
    static func flushItems( completion:@escaping (Bool)->Void ){
        
        if nextCallWillFail {
            completion(false)
        }else{
            storedItems = []
            completion(true)
        }
    }
}
