import UIKit

class CategoryCollectionView: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    private func setUpView() {
        collectionView.collectionViewLayout = Layouts.categoryLayout()
        collectionView.register(UINib(nibName: String(describing: CategoryViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryViewCell.self))
        collectionView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCell.self))
    }
}
