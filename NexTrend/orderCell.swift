import UIKit

class orderCell: UITableViewCell {

    @IBOutlet weak var oImage: UIImageView!
    
    @IBOutlet weak var oLabel: UILabel!
    
    @IBOutlet weak var oSize: UILabel!
    
    @IBOutlet weak var oQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        oImage.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
