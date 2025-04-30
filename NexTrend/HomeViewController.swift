import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var filteredNames: [String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tappedName = filteredNames[indexPath.row]
        guard let origIndex = allNames.firstIndex(of: tappedName) else { return }
        
        let segueID = "toCloth\(origIndex + 1)"
        
        performSegue(withIdentifier: segueID, sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredNames.removeAll()
            table.isHidden = true
        } else {
            filteredNames = allNames.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
            table.isHidden = filteredNames.isEmpty
        }
        table.reloadData()
        adjustTableHeight()
    }
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    func adjustTableHeight() {
        table.layoutIfNeeded()
        tableHeight.constant = table.contentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if shouldShowOrderPlacedAlert {
            showOrderPlacedAlert()
            shouldShowOrderPlacedAlert = false
        }
    }

    func showOrderPlacedAlert() {
        let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Track Order", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toOrder", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var username = "sushobhan"
    var shouldShowOrderPlacedAlert = false
    
    
    @IBOutlet weak var Count: UILabel!
    
    @IBOutlet weak var summer: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let allNames = ["Men Blue Martin Garrix Colorful Graphic Printed Oversized T-Shirt","Jet Black Casual Cotton Pants","Men Skipper Blue Naruto Graphic Printed Oversized Co-ordinates","Men Multicolor All Over Printed Oversized Shirt","Women Pink Super Loose Fit Joggers","Women Green Tweety Graphic Printed Co-ordinates","Women Pink Sea U Never Graphic Printed Oversized T-Shirt","Men Grey Muscle Fit T-Shirt","Women Pink Harry Potter Ora Graphic Printed Co-orditates","Men Brown Garfield Graphic Printed Oversized Co-ordinates","Women Orange This Is My Happy Face Fit Graphic T-Shirt","Women Graphic Printed 100% Cotton T-Shirt","Women White One Of A Kind Graphic Printed T-Shirt","Men Gardenia Who Cares Oversized T-Shirt","Men Blue Jeans","Men Blue Make Tracks Graphic Printed T-Shirt","Men Red Rider Graphic Printed T-Shirt","Women Black Whatever Cat Graphic Printed T-Shirt","Women Cress Green Olaf Graphic Printed Oversized T-Shirt","Women Jet Black Shorts"]
    let allImages = ["clt1.0","clt2.0","clt3.0","clt4.0","clt5.0","clt6.0","clt7.0","clt8.0","clt9.0","clt10.0","clt11.0","clt12.0","clt13.0","clt14.0","clt15.0","clt16.0","clt17.0","clt18.0","clt19.0","clt20.0"]
    let allPrices = [425,386,1349,649,923,1349,518,302,1285,1349,449,399,449,599,1399,399,399,399,799,499]

    var ID:[Int] = []
    var SIZE:[String] = []
    var QUANT:[Int] = []
    var orderId:[Int] = []
    var orderSize:[String] = []
    var orderQuant:[Int] = []
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Edge: NSLayoutConstraint!
    @IBAction func menu(_ sender: Any) {
        Edge.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
        @IBAction func closeMenu(_ sender: Any) {
            Edge.constant = -202
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    
    @IBAction func cartButton(_ sender: Any) {
        performSegue(withIdentifier: "toCartPage", sender: self)
    }
    
    @IBAction func orderHistory(_ sender: Any) {
        performSegue(withIdentifier: "toOrder", sender: self)
    }
    

    @IBOutlet weak var launchImage: UIImageView!
    @IBOutlet weak var launchesText: UILabel!
    let imageArr = ["launch1","launch2","launch3","launch4","launch5","launch6","launch7"]
    var currentImageIndex = 0
    var imageTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = username
        Edge.constant = -202
        launchImage.layer.cornerRadius = 10
        launchesText.layer.compositingFilter = "differenceBlendMode"
        summer.layer.compositingFilter = "differenceBlendMode"
        launchImage.clipsToBounds = true
        launchImage.image = UIImage(named: imageArr[currentImageIndex])
            
        imageTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateLaunchImage), userInfo: nil, repeats: true)
        Count.text = "\(ID.count)"
        Count.layer.cornerRadius = 5
        Count.clipsToBounds = true
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        
        table.isHidden = true
        print(orderId)
    }
    @objc func updateLaunchImage() {
        currentImageIndex = (currentImageIndex + 1) % imageArr.count
        let nextImage = UIImage(named: imageArr[currentImageIndex])
        
        UIView.transition(with: launchImage, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.launchImage.image = nextImage
        }, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCartPage":
            guard let dest = segue.destination as? CartViewController else { return }
            dest.prodID = ID
            dest.prodSize = SIZE
            dest.prodQuan = QUANT
            dest.allNames  = allNames
            dest.allImages = allImages
            dest.allPrices = allPrices
            dest.orderId = orderId
            dest.orderSize = orderSize
            dest.orderQuant = orderQuant

        case "toCloth1", "toCloth2", "toCloth3", "toCloth4", "toCloth5","toCloth6", "toCloth7", "toCloth8", "toCloth9", "toCloth10", "toCloth11", "toCloth12", "toCloth13", "toCloth14", "toCloth15", "toCloth16", "toCloth17", "toCloth18", "toCloth19", "toCloth20":
            guard let dest = segue.destination as? ProductPageViewController else { return }
            if let idString = segue.identifier?.dropFirst("toCloth".count),
               let idx = Int(idString),
               idx >= 1 && idx <= allNames.count {
                dest.nameLabel  = allNames[idx-1]
                dest.image      = UIImage(named: allImages[idx-1])
                dest.priceLabel = "₹\(allPrices[idx-1])"
                dest.id         = idx-1
                dest.prodID = ID
                dest.prodSize = SIZE
                dest.prodQuan = QUANT
                dest.orderId = orderId
                dest.orderSize = orderSize
                dest.orderQuant = orderQuant
            }
            
        case "toOrder":
            guard let dest = segue.destination as? OrderViewController else { return }
            dest.allNames = allNames
            dest.allImages = allImages
            dest.orderId = orderId
            dest.orderSize = orderSize
            dest.orderQuant = orderQuant
            dest.prodId = ID
            dest.prodSize = SIZE
            dest.prodQuant = QUANT
        default:
            break
        }
    }
}
