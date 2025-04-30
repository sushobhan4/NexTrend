import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        let user = username.text ?? ""
        let pass = password.text ?? ""
        
        if user.isEmpty {
            showAlert(message: "Please enter your username")
        } else if pass.isEmpty {
            showAlert(message: "Please enter your password")
        } else {
            performSegue(withIdentifier: "toHomePage", sender: user)
        }
    }
    
    var selectedURL = ""
    
    @IBAction func google(_ sender: Any) {
        selectedURL = "https://google.com/"
            performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    @IBAction func facebook(_ sender: Any) {
        selectedURL = "https://www.facebook.com"
            performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    @IBAction func twitter(_ sender: Any) {
        selectedURL = "https://www.x.com"
            performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeb" {
            if let destinationVC = segue.destination as? WebViewController {
                destinationVC.urlString = selectedURL
            }
        } else if segue.identifier == "toHomePage" {
            if let destinationVC = segue.destination as? HomeViewController,
               let usernamePassed = sender as? String {
                destinationVC.username = usernamePassed
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

