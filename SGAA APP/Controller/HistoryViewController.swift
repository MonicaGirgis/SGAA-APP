//
//  HistoryViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 11/10/2022.
//

import UIKit

class HistoryViewController: UIViewController {

    enum Section {
        case question(Bool)
        
        var isSelected: Bool {
            switch self {
            case .question(let bool):
                return bool
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var loader: UIView = {
       return createActivityIndicator(view)
    }()
    private var history: [History] = []
    private var sections: [Section] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        fetchData()
    }
    
    private func registerCells() {
        tableView.registerCellNib(cellClass: HistoryTableViewCell.self)
    }
    
    private func fetchData() {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .getHistory, decodingModel: [History].self) { [weak self] result in
            self?.loader.isHidden = true
            switch result {
            case .success(let data):
                self?.history = data
                self?.sections = Array(repeating: .question(true), count: data.count)
                self?.tableView.reloadData()
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isSelected ? history[section].answers.count + 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeue() as HistoryTableViewCell
            cell.dateLabel.text = history[indexPath.section].questionDate.getDate(fromFormat: "yyyy-MM-dd'T'HH:mm:ss.000Z")
            return cell
        case 1:
            let cell = tableView.dequeue() as HistoryDetailsTableViewCell
            cell.descLabel.text = history[indexPath.section].questionText
            return cell
        default:
            let cell = tableView.dequeue() as HistoryDetailsTableViewCell
            cell.descLabel.text = history[indexPath.section].answers[indexPath.row - 2].text
            return cell
        }
    }
 
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if selectedIndex == indexPath.row && isCollapse {
//            return 300
//        } else {
//            return 64
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 0 else { return}
        switch sections[indexPath.section] {
        case .question(let bool):
            sections.remove(at: indexPath.section)
            sections.insert(.question(!bool), at: indexPath.section)
        }
        tableView.reloadSections([indexPath.section], with: .automatic)
    }
    
}
