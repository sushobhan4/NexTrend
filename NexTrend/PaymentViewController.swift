import UIKit

class PaymentViewController: UIViewController {

    
    var total = ""
    
    @IBOutlet weak var amount: UILabel!
    
    var prodID: [Int] = []
    var prodSize: [String] = []
    var prodQuan: [Int] = []
    var allNames: [String] = []
    var allImages: [String] = []
    var allPrices: [Int] = []
    
    var orderId:[Int] = []
    var orderSize:[String] = []
    var orderQuant:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amount.text = total
        paying.layer.cornerRadius = 5
        paying.clipsToBounds = true
        print(orderId)
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: self)
    }
    
    @IBOutlet weak var paying: UILabel!
    
    
    @IBAction func pay(_ sender: Any) {
        performSegue(withIdentifier: "toFinal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCart",
           let dest = segue.destination as? CartViewController {
            dest.allImages = allImages
            dest.allNames = allNames
            dest.allPrices = allPrices
            dest.prodID = prodID
            dest.prodQuan = prodQuan
            dest.prodSize = prodSize
            dest.orderId = orderId
            dest.orderSize = orderSize
            dest.orderQuant = orderQuant
        }
        else if segue.identifier == "toFinal",
           let dest = segue.destination as? FinalViewController {
            dest.orderId = prodID
            dest.orderSize = prodSize
            dest.orderQuant = prodQuan

        }
    }

}
