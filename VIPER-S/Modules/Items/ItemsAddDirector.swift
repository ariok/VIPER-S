import Foundation

class ItemsAddDirector {
    
    var dataManager: ItemsAdd_ManageData!
    weak var ui: ItemsAdd_DisplayUI!
    var navigator: ItemsAdd_Navigate!
    
    var delegate: ItemsAdd_Delegate?
}


// MARK: - Present Data

extension ItemsAddDirector: ItemsAdd_PresentData{
    
    func presentSuccess(){
        delegate?.itemDidCreate()
        navigator.goBack()
    }
    
    func presentError(){
        ui.displayError()
        ui.toggle(loading: false)
    }
}


// MARK: - Handle UI Events

extension ItemsAddDirector: ItemsAdd_HandleUIEvents{
    
    func onSaveItem(name: String, enabled:Bool) {
        
        ui.toggle(loading: true)
        let item = Item(name: name, enabled: enabled, date: Date())
        dataManager.add(item: item)
    }
}
