import UIKit
import CoreData

class FavoutiesViewController: UIViewController, NibLoadable {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private let databaseHandler = DatabaseHandler()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let request: NSFetchRequest<Meal> = Meal.fetchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
//        databaseHandler.loadMeals()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        databaseHandler.loadMeals()
        tableView.reloadData()
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: FoodTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodTableViewCell.self))
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchMeal()
    }
}

extension FavoutiesViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        databaseHandler.meals.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseHandler.meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = databaseHandler.meals[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodTableViewCell.self), for: indexPath) as? FoodTableViewCell {
            cell.setUpCell(image: data.mealImage ?? "", title: data.mealTitle ?? "", firstSubtitle: String(data.mealReadyInMinutes), secondSubtitle: "\(data.mealServings) servings")
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(with: indexPath.row)
    }

    private func navigateToDetailView(with indexPath: Int) {
        let data = databaseHandler.meals[indexPath]
        let viewController = FavouritesDetailViewController()
        viewController.itemIndex = indexPath
        viewController.prepareView(with: data)
        show(viewController, sender: self)
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = view.backgroundColor
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5
//    }
}

extension FavoutiesViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .normal, title: "Remove") { action, view, completion in
            let removeMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this Meal?", preferredStyle: .alert)

            let yes = UIAlertAction(title: "Yes", style: .default) { action in
                self.databaseHandler.meals[indexPath.row].isFavourited = !self.databaseHandler.meals[indexPath.row].isFavourited
                self.context.delete(self.databaseHandler.meals[indexPath.row])
                self.databaseHandler.meals.remove(at: indexPath.row)

                self.databaseHandler.saveData()
                self.tableView.reloadData()
                self.databaseHandler.loadMeals()
            }

            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
                return
            }

            removeMessage.addAction(yes)
            removeMessage.addAction(cancel)

            self.present(removeMessage, animated: true, completion: nil)
        }

        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}

extension FavoutiesViewController {
    func searchMeal() {
        if let searchText = searchField.text {
            request.predicate = NSPredicate(format: "mealTitle CONTAINS[cd] %@", searchText)
            request.sortDescriptors = [NSSortDescriptor(key: "mealTitle", ascending: true)]

            do {
                databaseHandler.meals = try context.fetch(request)
            } catch {
                print("Error fetching tasks: \(error)")
            }

            tableView.reloadData()
        }
    }
}
