import Foundation

class ItemsAddWorker {
    
    weak var presenter: ItemsAdd_PresentData!
}

extension ItemsAddWorker: ItemsAdd_ManageData {
    
    
    func add(item: Item) {
        
        NetworkManager.add(item: item) {
            
            [weak self](completed) in
            
            if completed == true {
                self?.presenter.presentSuccess()
            }else {
                self?.presenter.presentError()
            }
        }
    }
}
