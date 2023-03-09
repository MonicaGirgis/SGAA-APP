//
//  RankingViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var students: [SameClassStudents]?
    var user: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func registerCells() {
        tableView.registerCellNib(cellClass: RankingTableViewCell.self)
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RankingTableViewCell
        cell.idLabel.text = students?[indexPath.row].studentId == user?.id ? user?.name : "\(students?[indexPath.row].studentId ?? 0)"
        cell.scoreLabel.text = "\(students?[indexPath.row].score ?? 0)"
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
