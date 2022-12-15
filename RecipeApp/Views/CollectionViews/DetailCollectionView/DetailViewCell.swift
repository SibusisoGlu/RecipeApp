import UIKit

class DetailViewCell: UICollectionViewCell {
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setUpViewStyle() {
        detailView.layer.cornerRadius = 10
        detailView.backgroundColor = .systemTeal
    }

    func setUpView(image: String, foodTitle: String, foodSubtitle: Int) {
        imageView.loadImage(fromURL: image)
        title.text = foodTitle
        subtitle.text = "\(foodSubtitle) mins"
    }

}
