import UIKit

class HeaderCell: UICollectionViewCell {
    @IBOutlet weak var headerText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerText.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }

}
