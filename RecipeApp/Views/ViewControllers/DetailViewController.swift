import UIKit

class DetailViewController: UIViewController, NibLoadable {
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func prepareView(with foodInformation: FoodDetailModel) {
        print(foodInformation.foodTitle)
    }
}
