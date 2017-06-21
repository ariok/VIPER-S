import Foundation

// MARK: - Protocols

protocol ItemsAdd_DisplayUI: class {
    func displayError()
    func displaySuccess()
    func toggle(loading:Bool)
}

protocol ItemsAdd_HandleUIEvents {
    func onSaveItem(name: String, enabled:Bool)
}

protocol ItemsAdd_ManageData{
    func add(item:Item)
}

protocol ItemsAdd_PresentData: class{
    func presentSuccess()
    func presentError()
}

protocol ItemsAdd_Navigate{
    func goBack()
}

protocol ItemsAdd_Delegate{
    func itemDidCreate()
}
