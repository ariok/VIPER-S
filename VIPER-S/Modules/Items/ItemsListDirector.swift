import UIKit

class ItemsListDirector {
    
    var dataManager: ItemsList_ManageData!
    var ui: ItemsList_DisplayUI!
    var navigator: ItemsList_Navigate!
    
    // Data
    
    var items: [Item] = []
    
    // UI
    
    var itemsUI: [ItemUI] {
        
        get {
            return items.map { // Converts Item array to an ItemUI array
                ItemUI(name: $0.name,
                       color: ($0.enabled) ? UIColor.darkGray : UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 1.0),
                       date: dateFormat(date: $0.date))
            }
        }
    }
}


// MARK: - Present Data

extension ItemsListDirector: ItemsList_PresentData{
    
    func present(items:[Item]){
        self.items = items
        ui.display(items: itemsUI)
        ui.toggle(loading: false)
        
    }
    
    func presentSuccess(){
        ui.displaySuccess()
        ui.toggle(loading: false)
    }
    
    func presentError(){
        ui.displayError()
        ui.toggle(loading: false)
    }
}


// MARK: - Handle UI Events


extension ItemsListDirector: ItemsList_HandleUIEvents{
    
    func onUIReady() {
        ui.toggle(loading: true)
        dataManager.fetchItems()
    }
    
    func onDeleteAll(){
        ui.toggle(loading: true)
        dataManager.deleteAllItems()
    }
    
    func onItemSelected(index:Int) {
        let item = items[index]
        navigator.gotoDetail(for: item)
    }
    
    func onAddItem() {
        navigator.gotoAddItem(with: self)
    }
}

extension ItemsListDirector: ItemsAdd_Delegate {
    
    func itemDidCreate() {
        ui.toggle(loading: true)
        dataManager.fetchItems()
    }
}
