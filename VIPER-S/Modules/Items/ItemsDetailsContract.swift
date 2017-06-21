import Foundation

protocol ItemsDetails_DisplayUI: class {
    func display(name:String)
    func display(state:String)
    func display(date:String)
}

protocol ItemsDetails_HandleUIEvents {
    func onUIReady()
}
