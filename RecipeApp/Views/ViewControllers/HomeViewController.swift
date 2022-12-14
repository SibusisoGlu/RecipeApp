import UIKit

class HomeViewController: UIViewController, NibLoadable, FoodInformationDelegate {

    @IBOutlet weak var personalMealView: UIView!
    
    @IBOutlet weak var recommendedMealsView: UIView!
    
    private let viewModel = RecipeViewModel()
    private var searchController = UISearchController(searchResultsController: nil)
    var foodData: [FoodDetailModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureSearchController()
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meal"
        searchController.searchBar.setValue("Done", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        print(foodList)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
           searchController.isActive {
            updateResults(for: searchText)
//            print(searchText)
        }
    }

    func updateResults(for searchText: String) {
        if searchText.isEmpty {
//            filteredPets = pets
            print("No Text")
        } else {
//            filteredPets = filterPets(for: searchText)
            filterText(for: searchText)
        }
//         needs to be replaced by snapshot
//        collectionView.reloadData()
//        updateSnapshot()
    }

//    func filterPets(for searchText: String) -> [PetSearchData] {
//        return pets.filter {
//            return $0.name?.lowercased().contains(searchText.lowercased()) ?? false
//        }
//    }
    func filterText(for searchText: String) {
        print(searchText.lowercased())

//        viewModel.getRecipeInformation(with: searchText.lowercased())
    }
}
