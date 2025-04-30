import UIKit

class ProductPageViewController: UIViewController {

    var Q = 1
    var id = 0
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBAction func stepperAction(_ sender: UIStepper) {
        Q = Int(sender.value)
        quantity.text = "x\(Q)"
        
    }
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var image: UIImage?
    var nameLabel = "test"
    var priceLabel = "test"
    var prodID: [Int] = []
    var prodSize: [String] = []
    var prodQuan: [Int] = []
    
    var orderId:[Int] = []
    var orderSize:[String] = []
    var orderQuant:[Int] = []
    
    var isInCart = false
    
    @IBOutlet weak var addToCartOutlet: UIButton!
    @IBOutlet weak var removeoutlet: UIButton!
    
    @IBAction func addToCartButton(_ sender: Any){
        guard !isInCart else { return }
        isInCart = true
        addToCartOutlet.isHidden = true
        removeoutlet.isHidden   = false
    }
    
    
    @IBAction func remove(_ sender: Any) {
        guard isInCart else { return }
        isInCart = false
        removeoutlet.isHidden   = true
        addToCartOutlet.isHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        if isInCart{
            let selectedSize = size.titleForSegment(at: size.selectedSegmentIndex) ?? "N/A"
            
            prodSize.append(selectedSize)
            prodQuan.append(Q)
            prodID.append(id)
        }
        performSegue(withIdentifier: "backToHome", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHome",
           let destinationVC = segue.destination as? HomeViewController {
            destinationVC.ID = prodID
            destinationVC.SIZE = prodSize
            destinationVC.QUANT = prodQuan
            
            destinationVC.orderId = orderId
            destinationVC.orderSize = orderSize
            destinationVC.orderQuant = orderQuant
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let existingIndex = prodID.firstIndex(of: id) {
            // pull out the saved size & quantity
            let existingSize  = prodSize[existingIndex]
            let existingCount = prodQuan[existingIndex]

            for i in 0..<size.numberOfSegments {
                if size.titleForSegment(at: i) == existingSize {
                    size.selectedSegmentIndex = i
                    break
                }
            }
            
            print(orderId)
            
            Q = existingCount
            stepper.value   = Double(Q)
            quantity.text   = "x\(Q)"

            isInCart = true
            addToCartOutlet.isHidden = true
            removeoutlet.isHidden = false

            prodID.remove(at: existingIndex)
            prodSize.remove(at: existingIndex)
            prodQuan.remove(at: existingIndex)
        }
        
        mainImage.image  = image
        name.text = nameLabel
        price.text = priceLabel
        stepper.minimumValue = 1
        stepper.value        = Double(Q)
        quantity.text        = "x\(Q)"
        backButton.layer.compositingFilter = "differenceBlendMode"
        removeoutlet.isHidden    = !isInCart
        addToCartOutlet.isHidden =  isInCart
    }
}
