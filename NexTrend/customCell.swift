import UIKit

protocol CustomCellDelegate: AnyObject{
    func didUpdateQuantity(for cell: customCell, newQuantity: Int)
    func didPressDeleteButton(for cell: customCell)
}

class customCell: UITableViewCell {
    
    var c = 1
    var unitPrice: Int = 0
    
    weak var delegate: CustomCellDelegate?

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLable: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBAction func stepperAction(_ sender: UIStepper) {
        c = Int(sender.value)
        productQuantity.text = "x\(c)"
        let updatedPrice = unitPrice * c
        productPrice.text = "₹\(updatedPrice)"
        delegate?.didUpdateQuantity(for: self, newQuantity: c)
    }
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.didPressDeleteButton(for: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.minimumValue = 1
        stepper.value = Double(c)
        productQuantity.text = "x\(c)"
        productImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
