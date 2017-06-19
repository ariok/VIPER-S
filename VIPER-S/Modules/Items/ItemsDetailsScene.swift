import UIKit

class ItemsDetailsScene: UIViewController {
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var stateLabel:UILabel!

    
    var eventsHandler: ItemsDetails_HandleUIEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsHandler.onUIReady()
    }
}

extension ItemsDetailsScene: ItemsDetails_DisplayUI {
    
    func display(name: String) {
        title = "ITEM: \(name)"
        nameLabel.text = name
    }
    
    func display(date: String) {
        dateLabel.text = date
    }
    
    func display(state: String) {
        stateLabel.text = state
    }
}
