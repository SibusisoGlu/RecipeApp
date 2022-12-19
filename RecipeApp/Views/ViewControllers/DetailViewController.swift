import UIKit

class DetailViewController: UIViewController, NibLoadable {
    @IBOutlet weak private var topContainer: UIView!
    @IBOutlet weak private var bottomContainer: UIView!

    private var foodData: FoodDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        addBottomContainerView()
    }

    func prepareView(with foodInformation: FoodDetailModel) {
        foodData = foodInformation
    }

    private func addBottomContainerView() {
        let bundle = Bundle.main
        guard let segmentControlView = bundle.loadNibNamed("SegmentControlView", owner: self)?.first as? SegmentControlView else {
            return
        }

        self.bottomContainer.addSubview(segmentControlView)
        segmentControlView.pinEdges(to: self.bottomContainer)
    }

}
