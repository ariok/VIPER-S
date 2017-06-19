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
        UIApplication.shared.open(shamelessURL, options: [:], completionHandler: nil)
    }
}
