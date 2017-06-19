import UIKit


// MARK: - TypeDef

struct Item{
    let name: String
    var enabled: Bool
    let date: Date
}

struct ItemUI {
    let name: String
    let color: UIColor
    let date: String
}


// MARK: - Protocols

protocol ItemsList_DisplayUI {
    func toggle(loading:Bool)
    func display(items: [ItemUI])
    func displayError()
    func displaySuccess()
}

protocol ItemsList_HandleUIEvents {
    func onUIReady()
    func onDeleteAll()
    func onAddItem()
    func onItemSelected(index: Int)
}

protocol ItemsList_ManageData{
    func fetchItems()
    func deleteAllItems()
}

protocol ItemsList_PresentData{
    func present(items:[Item])
    func presentSuccess()
    func presentError()
}

protocol ItemsList_Navigate{
    func gotoDetail(`for` item:Item)
    func gotoAddItem(with delegate:ItemsAdd_Delegate?)
    func goBack()
}
