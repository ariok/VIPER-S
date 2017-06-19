import Foundation

protocol ItemsDetails_DisplayUI {
    func display(name:String)
    func display(state:String)
    func display(date:String)
}

protocol ItemsDetails_HandleUIEvents {
    func onUIReady()
}
