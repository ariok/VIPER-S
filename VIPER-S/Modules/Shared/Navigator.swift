import UIKit

class Navigator {
    
    weak var viewController:UIViewController!
    
    init(with viewController:UIViewController) {
        self.viewController = viewController
    }
    
    static func instantiateController(id:String, storyboard:String, bundle:Bundle? = nil)-> UIViewController{
        
        let storyBoard = UIStoryboard(name: storyboard, bundle: bundle)
        let viewController = storyBoard.instantiateViewController(withIdentifier:id)
        
        return viewController
    }
    
    func push(nextViewController:UIViewController, animated:Bool = true, completion: (() -> Void)? = nil)  {
        
        if let navigationController = viewController.navigationController {
            _ = navigationController.pushViewController(nextViewController, animated: animated)
        }else{
            viewController.present(nextViewController, animated: animated, completion: completion)
        }
    }
    
    func pop(){
        _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    func present(modalViewController:UIViewController, animated:Bool = true, completion: (() -> Void)? = nil){
        viewController.present(modalViewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil ){
        viewController.dismiss(animated: true, completion: completion)
    }
    
}
