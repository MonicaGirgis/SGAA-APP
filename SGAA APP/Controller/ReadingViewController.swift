//
//  ReadingViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 09/10/2022.
//

import UIKit

class ReadingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var questions: [Question] = [Question(quesestion: "Heelo", answers: ["true", "wrong"]), Question(quesestion: "Heelo", answers: ["true", "wrong"]), Question(quesestion: "Heelo", answers: ["true", "wrong", "fdfdkf"]), Question(quesestion: "Heelo", answers: ["true", "wrong","true", "wrong"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func registerCells() {
        tableView.registerCellNib(cellClass: AnswerTableViewCell.self)
    }
    
}

extension ReadingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].answers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as AnswerTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderOfQuestion()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == questions.count - 1 {
        let footerView = SubmitView()
        return footerView
        } else {
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == questions.count - 1 {
            return 50
        } else {
            return 0
        }
    }
    
}


struct Question {
    let quesestion: String
    let answers: [String]
}
