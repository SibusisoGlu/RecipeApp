import UIKit

class SearchViewController: UIViewController, NibLoadable, FoodInformationDelegate {
    @IBOutlet weak var searchBarText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = RecipeViewModel()
    private var foodInformation: [FoodDetailModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpTableView()
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: FoodTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodTableViewCell.self))
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        foodInformation = foodList
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let searchText = searchBarText.text else { return }

        let filteredText = filterText(with: searchText)
        
        if searchText == "" {
            searchBarText.text = "Enter your meal"
        } else {
            viewModel.getRecipeInformation(with: filteredText)
            tableView.reloadData()
        }
    }

    private func filterText(with text: String) -> String {
        let trimmedSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let filteredSearchText = trimmedSearchText.replacingOccurrences(of: " ", with: "+")
        return filteredSearchText
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInformation.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = foodInformation[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodTableViewCell.self), for: indexPath) as? FoodTableViewCell {
            cell.setUpCell(image: data.foodImage, title: data.foodTitle, firstSubtitle: String(data.foodReadyInMinutes), secondSubtitle: String(data.foodServings))
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(with: indexPath.row)
    }

    private func navigateToDetailView(with indexPath: Int) {
        let data = foodInformation[indexPath]
        let viewController = DetailViewController()
        viewController.prepareView(with: data)
        show(viewController, sender: self)
    }
}
