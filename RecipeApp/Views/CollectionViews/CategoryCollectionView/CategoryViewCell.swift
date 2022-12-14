import UIKit

class CategoryViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViewStyle()
    }

    func setUpView(titleText: String) {
        title.text = titleText
    }

    private func setUpViewStyle() {
        categoryView.layer.cornerRadius = 10
    }
}
