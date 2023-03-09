//
//  ReadingViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 09/10/2022.
//

import UIKit

class ReadingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dateView: UIView!
    
    private lazy var loader: UIView = {
       return createActivityIndicator(view)
    }()
    
    private var reading: Reading?
    private var selectedAnswers: [AnswersModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCells()
        fetchData()
    }
    
    private func registerCells() {
        tableView.registerCellNib(cellClass: AnswerTableViewCell.self)
    }
    
    private func setupUI() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(collapseView))
        dateView.addGestureRecognizer(gesture)
    }
    
    @objc
    private func collapseView() {
        if textViewHeight.constant == 0{
          setData()
        }else {
            textViewHeight.constant = 0
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func setData() {
        guard let reading = reading else { return}
        dateLabel.text = reading.date.getDate()
        descTextView.text = reading.context
        
        if descTextView.contentSize.height >= 300{
            textViewHeight.constant = 300
        }else if descTextView.contentSize.height < 100{
            textViewHeight.constant = 100
        }
        else {
            textViewHeight.constant = descTextView.contentSize.height
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func fetchData() {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .getReading, decodingModel: Reading.self) { [weak self] result in
            self?.loader.isHidden = true
            switch result {
            case .success(let data):
                self?.reading = data
                self?.setData()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func submitAnswers() {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .submitAnswers(answers: selectedAnswers, readingId: reading?.id), decodingModel: String.self) { [weak self] result in
            self?.loader.isHidden = true
            switch result {
            case .success(let data):
                windows?.make(toast: data)
                self?.selectedAnswers.removeAll()
                self?.tableView.reloadData()
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textViewHeight.constant = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

extension ReadingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return reading?.questions.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (reading?.questions[section].answers.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as AnswerTableViewCell
        let answer = reading?.questions[indexPath.section].answers[indexPath.row]
        let isSelected = selectedAnswers.first(where: { $0.questionId == reading?.questions[indexPath.section].id })?.answerId == answer?.id
        cell.setData(txt: answer?.text ?? "", isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderOfQuestion()
        let question = reading?.questions[section]
        headerView.setData(text: question?.text ?? "")
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == (reading?.questions.count ?? 0) - 1 {
        let footerView = SubmitView()
            footerView.didSubmit = { [weak self] in
                self?.submitAnswers()
            }
        return footerView
        } else {
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (reading?.questions.count ?? 0) - 1 {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = reading?.questions[indexPath.section]
        if let index = selectedAnswers.firstIndex(where: { $0.questionId == question?.id }) {
            selectedAnswers[index].answerId = question?.answers[indexPath.row].id ?? 0
        }else{
            selectedAnswers.append(AnswersModel(questionId: question?.id ?? 0, answerId: question?.answers[indexPath.row].id ?? 0))
        }
        tableView.reloadSections([indexPath.section], with: .automatic)
    }
}
