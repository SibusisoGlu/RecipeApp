import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellFirstSubtitle: UILabel!
    @IBOutlet weak var cellSecondSubtitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setUpView() {
        cellImageView.layer.cornerRadius = 100
        cellImageView.clipsToBounds = true

        cellView.layer.cornerRadius = 15
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.systemGray6.cgColor
    }

    func setUpCell(image: String, title: String, firstSubtitle: String, secondSubtitle: String) {
        cellImageView.loadImage(fromURL: image)
        cellTitle.text = title
        ImageString.imageStringConfigurator(with: cellFirstSubtitle, and: firstSubtitle)
        cellSecondSubtitle.text = secondSubtitle
    }
    
}
