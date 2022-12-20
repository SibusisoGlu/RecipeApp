import UIKit

protocol Favouritable {
    func toggleFavourite(for view: UIView)
}

class FoodDetailView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodTime: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    var favouriteDelegate: Favouritable?

    func setUpView(with image: String, _ title: String, _ time: Int, isFavourite: Bool) {
        imageView.loadImage(fromURL: image)
        foodTitle.text = title
        foodTime.text = "\(time) mins"

        checkFavourite(isFavourite: isFavourite)
    }

    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        print("tapped on event")

        favouriteDelegate?.toggleFavourite(for: self)
    }

    func checkFavourite(isFavourite: Bool) {
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
