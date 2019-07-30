import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gotoItems(){
        
        let items = ItemsListNavigator.makeModule()
        let navigation = UINavigationController(rootViewController: items)
        self.present(navigation, animated: true, completion: nil)
        
    }
    
    @IBAction func gotoTwitter(){
        
        let shamelessURL = URL(string: "https://twitter.com/bitwaker")!
        UIApplication.shared.open(shamelessURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
