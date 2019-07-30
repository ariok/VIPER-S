import UIKit

class ItemsListScene: UIViewController {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var loader: UIView!
    
    var items: [ItemUI] = []
    var eventsHandler: ItemsList_HandleUIEvents!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        eventsHandler.onUIReady()
        
        title = "ITEMS"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(ItemsListScene.addItem))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Display UI

extension ItemsListScene: ItemsList_DisplayUI {
    
    func toggle(loading: Bool) {
        
        if loading {
            loader.frame = view.bounds
            view.addSubview(loader)
        }else{
            loader.removeFromSuperview()
        }
    }
    
    func display(items: [ItemUI]) {
        self.items = items
        table.reloadData()
    }
    
    func displayError(){
        /**
         Here you could present messages with popup or updating UI elements
         for the sake of simplicity, we just log a message
         **/
        print("Something went wrong")
    }
    
    func displaySuccess(){
        /** 
        Here you could present messages with popup or updating UI elements 
        for the sake of simplicity, we just log a message
        **/
        print("Operation completed")
    }
}


// MARK: - UI Interaction

extension ItemsListScene {
    
    @IBAction func deleteAll(){
        eventsHandler.onDeleteAll()
    }
    
    @objc func addItem(){
        eventsHandler.onAddItem()
    }
}


// MARK: - Table 

extension ItemsListScene: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")
        let item = items[indexPath.row]
        
        let nameLabel = cell!.viewWithTag(1) as! UILabel
        let dateLabel = cell!.viewWithTag(2) as! UILabel
        
        nameLabel.text = item.name
        nameLabel.textColor = item.color
        dateLabel.text = item.date
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        eventsHandler.onItemSelected(index: indexPath.row)
    }
    
}
