import Foundation

class ItemsAddNavigator: Navigator {
    
    static func makeModule(with delegate:ItemsAdd_Delegate?)-> ItemsAddScene {
        
        // Crete the actors
        
        let scene = instantiateController(id: "Add", storyboard: "Items") as! ItemsAddScene
        let navigator = ItemsAddNavigator(with: scene)
        let worker = ItemsAddWorker()
        let director = ItemsAddDirector()
        
        // Associate actors
        
        director.dataManager = worker
        director.navigator = navigator
        director.ui = scene
        director.delegate = delegate
        worker.presenter = director
        scene.eventsHandler = director
        
        return scene
    }
}

extension ItemsAddNavigator: ItemsAdd_Navigate{
    
    func goBack(){
        pop()
    }
}
