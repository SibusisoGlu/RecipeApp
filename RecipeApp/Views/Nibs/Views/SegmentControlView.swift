import UIKit

class SegmentControlView: UIView {
    typealias dataSourceSnapshot = NSDiffableDataSourceSnapshot

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var foodStepData: [Step] = []
    var steps: [String] = []

    func prepareView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: SegmentControlCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SegmentControlCell.self))
    }

    func generateSteps() {
        for step in foodStepData {
            steps.append(step.step ?? "")
        }
    }

    @IBAction func SegmentControlPressed(_ sender: UISegmentedControl) {

    }
}

extension SegmentControlView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        steps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentControlCell.self), for: indexPath) as! SegmentControlCell
        cell.title.text = steps[indexPath.row]
        return cell
    }

    
}
