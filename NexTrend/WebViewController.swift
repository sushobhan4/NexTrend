import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var webKit: WKWebView!
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webKit.load(request)
        }
    }
}
