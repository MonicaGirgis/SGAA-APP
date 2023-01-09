//
//  HistoryTableViewCell.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 11/10/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    private var questions: [Question] = [Question(quesestion: "Heelo", answers: ["true", "wrong"]), Question(quesestion: "Heelo", answers: ["true", "wrong"]), Question(quesestion: "Heelo", answers: ["true", "wrong", "fdfdkf"]), Question(quesestion: "Heelo", answers: ["true", "wrong","true", "wrong"])]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
    }
    
    private func registerCells() {
        tableView.registerCellNib(cellClass: HistoryDetailsTableViewCell.self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HistoryTableViewCell: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HistoryDetailsTableViewCell
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
}
