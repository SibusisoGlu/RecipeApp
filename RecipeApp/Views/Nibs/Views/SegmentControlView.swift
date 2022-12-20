import UIKit

class SegmentControlView: UIView {
    typealias dataSourceSnapshot = NSDiffableDataSourceSnapshot

    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var tableView: UITableView!

    var foodStepData: [Step] = []
    private var steps: [String] = []
    private var ingredients: [String] = []

    func prepareView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: SegmentControlCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SegmentControlCell.self))

        segmentedControl.setTitle("Instructions", forSegmentAt: 0)
        segmentedControl.setTitle("Ingredients", forSegmentAt: 1)
    }

    func generateData() {
        for step in foodStepData {
            steps.append(step.step ?? "")
            guard let ingredientData = step.ingredients else { return }
            for ingredient in ingredientData {
                ingredients.append(ingredient.name ?? "")
            }
        }
    }

    lazy var rowsToDisplay = steps

    @IBAction func SegmentControlPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rowsToDisplay = steps
            tableView.reloadData()
        case 1:
            rowsToDisplay = ingredients
            tableView.reloadData()
        default:
            rowsToDisplay = []
            tableView.reloadData()
        }
    }
}

extension SegmentControlView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentControlCell.self), for: indexPath) as! SegmentControlCell

        if rowsToDisplay == steps {
            cell.title.text = rowsToDisplay[indexPath.row]
            return cell
        } else if rowsToDisplay == ingredients {
            cell.title.text = rowsToDisplay[indexPath.row]
            return cell
        } else {
            cell.title.text = ""
            return cell
        }
    }
}
