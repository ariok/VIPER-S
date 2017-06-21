import Foundation

class ItemsDetailsDirector {
    var item:Item!
    weak var ui: ItemsDetails_DisplayUI!
}

extension ItemsDetailsDirector: ItemsDetails_HandleUIEvents {
    
    func onUIReady() {
        
        ui.display(name: item.name)
        ui.display(date: dateFormat(date: item.date))
        ui.display(state: item.enabled ? "Enabled" : "Disabled")
    }
}

