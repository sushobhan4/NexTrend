import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func create(_ sender: Any) {
        guard let usernameText = username.text, !usernameText.isEmpty,
              let emailText = email.text, !emailText.isEmpty,
              let passwordText = password.text, !passwordText.isEmpty,
              let confirmPasswordText = confirmPassword.text, !confirmPasswordText.isEmpty else {
            showAlert(message: "All fields are mandatory.")
            return
        }

        guard isValidEmail(emailText) else {
            showAlert(message: "Invalid email address.")
            return
        }

        guard passwordText == confirmPasswordText else {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Proceed to HomeViewController
        performSegue(withIdentifier: "toHome", sender: usernameText)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome",
           let destinationVC = segue.destination as? HomeViewController,
           let usernameText = sender as? String {
            destinationVC.username = usernameText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}
