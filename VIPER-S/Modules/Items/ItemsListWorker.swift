import Foundation

class ItemsListWorker {
    
    var presenter: ItemsList_PresentData!
}

extension ItemsListWorker: ItemsList_ManageData {
    
    func fetchItems(){
        
        NetworkManager.getItems(){
            
            [weak self](items, completed)->Void in
            
            if completed == true {
                self?.presenter.present(items: items)
            }else {
                self?.presenter.presentError()
            }
        }
    }
    
    func deleteAllItems(){
        
        NetworkManager.flushItems(){
            
            [weak self](completed)->Void in
            
            if completed == true {
                self?.presenter.present(items:[])
            }else {
                self?.presenter.presentError()
            }
        }
    }
}
