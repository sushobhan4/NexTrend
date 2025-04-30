import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var tick: UIImageView!
    
    var orderId:[Int] = []
    var orderSize:[String] = []
    var orderQuant:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tick.isHidden = true
        activity.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tick.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.performSegue(withIdentifier: "toHome", sender: self)
            }
        }
        print(orderId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            if let homeVC = segue.destination as? HomeViewController {
                homeVC.shouldShowOrderPlacedAlert = true
                homeVC.orderId = orderId
                homeVC.orderSize = orderSize
                homeVC.orderQuant = orderQuant
            }
        }
    }
}
