import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellFirstSubtitle: UILabel!
    @IBOutlet weak var cellSecondSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCell(image: String, title: String, firstSubtitle: String, secondSubtitle: String) {
        cellImageView.loadImage(fromURL: image)
        cellTitle.text = title
        cellFirstSubtitle.text = firstSubtitle
        cellSecondSubtitle.text = secondSubtitle
    }
    
}
