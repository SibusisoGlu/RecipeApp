import UIKit

class HomeViewController: UIViewController, NibLoadable {
    @IBOutlet weak var personalMealView: UIView!
    @IBOutlet weak var recommendedMealsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBottomContainer()
        setUpNavigationItem()
    }

    private func setUpNavigationItem() {
        let favouritesButton = UIBarButtonItem(title: "Favs", style: .plain, target: self, action: #selector(goToHelp))
        navigationItem.rightBarButtonItem = favouritesButton
    }

    @objc func goToHelp() {
        let favoutitesViewController = FavoutiesViewController()
        navigationController?.pushViewController(favoutitesViewController, animated: true)
    }

    private func setUpBottomContainer() {
        let controller = DetailCollectionView(collectionViewLayout: UICollectionViewLayout())

        addChild(controller)

        controller.collectionView.translatesAutoresizingMaskIntoConstraints = false
        recommendedMealsView.addSubview(controller.collectionView)

        NSLayoutConstraint.activate([
            controller.collectionView.leftAnchor.constraint(equalTo: recommendedMealsView.leftAnchor),
            controller.collectionView.topAnchor.constraint(equalTo: recommendedMealsView.topAnchor),
            controller.collectionView.rightAnchor.constraint(equalTo: recommendedMealsView.rightAnchor),
            controller.collectionView.bottomAnchor.constraint(equalTo: recommendedMealsView.bottomAnchor)])

        controller.didMove(toParent: self)
    }

}
