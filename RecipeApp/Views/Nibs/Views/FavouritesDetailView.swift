import UIKit

class FavouritesDetailView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    var foodData: Meal?

    func setUpView() {
        guard let data = foodData else { return }

        imageView.loadImage(fromURL: data.mealImage ?? "")
        titleLable.text = data.mealTitle
        subTitleLabel.text = "\(data.mealReadyInMinutes) mins"
    }
}
