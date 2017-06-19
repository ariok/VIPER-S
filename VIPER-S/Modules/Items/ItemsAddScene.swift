import UIKit

class ItemsAddScene: UIViewController {
    
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var stateSwitch: UISwitch!
    @IBOutlet var loader:UIView!
    
    var eventsHandler: ItemsAdd_HandleUIEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ADD ITEM"
    }
}


// MARK: - Display UI

extension ItemsAddScene: ItemsAdd_DisplayUI {
    
    func toggle(loading: Bool) {
        
        if loading {
            loader.frame = view.bounds
            loader.alpha = 0.8
            view.addSubview(loader)
        }else{
            loader.removeFromSuperview()
        }
    }
    
    func displayError(){
        print("Something goes wrong")
    }
    
    func displaySuccess(){
        print("Operation completed")
    }
}


// MARK: - UI Interaction

extension ItemsAddScene {
    
    @IBAction func save(){
        eventsHandler.onSaveItem(name: nameTextfield.text!, enabled: stateSwitch.isOn)
    }
}
