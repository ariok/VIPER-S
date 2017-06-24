import Foundation

class ItemsDetailsNavigator: Navigator {
    
    static func makeModule(with item:Item)-> ItemsDetailsScene {
        
        // Crete the actors
        
        let scene = instantiateController(id: "Details", storyboard: "Items", bundle:Bundle(for: self)) as! ItemsDetailsScene
        let director = ItemsDetailsDirector()
        
        // Associate actors
        
        director.ui = scene
        director.item = item
        scene.eventsHandler = director
        
        return scene
    }
}
