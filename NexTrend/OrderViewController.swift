import UIKit

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Ocell", for: indexPath) as! orderCell
        
        let index = orderId[indexPath.row]
            
        cell.oLabel.text = allNames[index]
        cell.oImage.image = UIImage(named: allImages[index])
        cell.oSize.text = "Size: \(orderSize[indexPath.row])"
        cell.oQuantity.text = "x\(orderQuant[indexPath.row])"
        
        return cell
    }
    
    var orderId:[Int] = []
    var orderSize:[String] = []
    var orderQuant:[Int] = []
    var allNames:[String] = []
    var allImages:[String] = []
    
    var prodId:[Int] = []
    var prodSize:[String] = []
    var prodQuant:[Int] = []
    
    @IBOutlet weak var empty: UILabel!
    
    @IBOutlet weak var arriving: UILabel!
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            if let dest = segue.destination as? HomeViewController{
                dest.orderId = orderId
                dest.orderSize = orderSize
                dest.orderQuant = orderQuant
                dest.ID = prodId
                dest.SIZE = prodSize
                dest.QUANT = prodQuant
            }
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        table.register(UINib(nibName: "orderCell", bundle: nil), forCellReuseIdentifier: "Ocell")
        
        if orderId.count == 0 {
            empty.isHidden = false
            arriving.isHidden = true
        } else {
            empty.isHidden = true
            arriving.isHidden = false
        }
        print(orderId)
    }

}
