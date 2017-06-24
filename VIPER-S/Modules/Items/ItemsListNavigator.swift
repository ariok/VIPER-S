import Foundation

class ItemsListNavigator: Navigator {
    
    static func makeModule()-> ItemsListScene {
        
        // Crete the actors
        let scene = instantiateController(id: "List", storyboard: "Items", bundle:Bundle(for: self)) as! ItemsListScene
        let navigator = ItemsListNavigator(with: scene)
        let worker = ItemsListWorker()
        let director = ItemsListDirector()
        
        // Associate actors
        
        director.dataManager = worker
        director.navigator = navigator
        director.ui = scene
        worker.presenter = director
        scene.eventsHandler = director
        
        return scene
    }
}

extension ItemsListNavigator: ItemsList_Navigate{
    
    func gotoDetail(`for` item: Item) {
        let itemDetail = ItemsDetailsNavigator.makeModule(with: item)
        push(nextViewController: itemDetail)
    }
    
    func goBack(){
        dismiss(animated:true)
    }
    
    func gotoAddItem(with delegate:ItemsAdd_Delegate?) {
        let itemAdd = ItemsAddNavigator.makeModule(with: delegate)
        push(nextViewController: itemAdd)
    }
    
}
