import UIKit

class CartViewController: UIViewController,CustomCellDelegate,UITableViewDataSource, UITableViewDelegate {
    func didUpdateQuantity(for cell: customCell, newQuantity: Int) {
        if let indexPath = table.indexPath(for: cell) {
                prodQuan[indexPath.row] = newQuantity
                updateTotal()
            }
    }
    
    func didPressDeleteButton(for cell: customCell) {
        if let indexPath = table.indexPath(for: cell)
        {
            prodID.remove(at: indexPath.row)
            prodSize.remove(at: indexPath.row)
            prodQuan.remove(at: indexPath.row)
            
            table.deleteRows(at: [indexPath], with: .automatic)
            updateTotal()
        }
        if prodID.count == 0{
            isEmpty.isHidden = false
        }
        
        else
        {
            isEmpty.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        let index = prodID[indexPath.row]
        
        cell.productLable.text = allNames[index]
        cell.productImage.image = UIImage(named: allImages[index])
        cell.unitPrice = allPrices[index]  // 💡 Important
        cell.productPrice.text = "₹\(allPrices[index] * prodQuan[indexPath.row])"
        cell.productSize.text = "Size: \(prodSize[indexPath.row])"
        cell.c = prodQuan[indexPath.row]
        cell.stepper.value = Double(prodQuan[indexPath.row])
        cell.productQuantity.text = "x\(prodQuan[indexPath.row])"
        cell.delegate = self
        
        return cell
    }
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var isEmpty: UILabel!
    
    var totalSum = 0
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
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        updateTotal()
        
        if prodID.count == 0{
            isEmpty.isHidden = false
        }
        
        else
        {
            isEmpty.isHidden = true
        }
        print(orderId)
    }
    
    func updateTotal() {
        totalSum = 0
        for i in 0..<prodID.count {
            let price = allPrices[prodID[i]]
            totalSum += price * prodQuan[i]
        }
        total.text = "₹\(totalSum)"
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: self)
        
    }
    
    
    @IBAction func order(_ sender: Any) {
        if totalSum > 0 {
                performSegue(withIdentifier: "toPayment", sender: self)
            } else {
                let alert = UIAlertController(title: "Cart is empty", message: "Please add items to your cart before proceeding to payment.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
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
        else if segue.identifier == "toPayment",
           let dest = segue.destination as? PaymentViewController {
            dest.total = "₹\(totalSum)"
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
    }
}
