//
//  ProfileViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var questionsLabel: UILabel!
    @IBOutlet weak var rightPercentageLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankingButton: UIButton!
    
    
    private lazy var loader: UIView = {
       return createActivityIndicator(view)
    }()
    private var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        progressBar.layer.borderWidth = 1
        progressBar.layer.borderColor = #colorLiteral(red: 0.3881214559, green: 0.7388194799, blue: 0.6383794546, alpha: 1).cgColor
        progressBar.layer.cornerRadius = 0.8
    }
    
    private func fetchData() {
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .getProfile, decodingModel: Profile.self) { [weak self] result in
            self?.loader.isHidden = true
            switch result {
            case .success(let data):
                self?.profile = data
                self?.setData(profile: data)
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    private func setData(profile: Profile) {
        nameLabel.text = profile.student.name
        classLabel.text = profile.student.myClass.name
        coinsLabel.text = "\(profile.student.coins ?? 0)"
        levelLabel.text = "Level".localized + " " + "\(profile.level)"
        readingLabel.text = "\(profile.totalReadings)" + " " + "Days".localized
        questionsLabel.text = "\(profile.totalQuestions)" + " " + "Questions".localized
        rightPercentageLabel.text = "\(profile.rightAnswersPercentage)" + "%"
        progressBar.progress = Float(profile.progress) / 100
        pointsLabel.text = "\(profile.student.score ?? 0)" + " " + "points to level up"
        rankingButton.setTitle("Ranking" + " " + profile.student.className, for: .normal)
    }

    @IBAction func didPressRanking(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
        vc.students = profile?.sameClassStudents
        vc.user = profile?.student
        _ = vc.presentAsActionSheetPopup(in: self, draggable: true, preferedHeight: view.frame.height * 0.7)
    }
    
}
