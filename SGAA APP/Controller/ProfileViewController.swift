//
//  ProfileViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.layer.borderWidth = 1
        progressBar.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        progressBar.layer.cornerRadius = progressBar.frame.height/2
    }

    @IBAction func didPressRanking(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RankingViewController")
        _ = vc?.presentAsActionSheetPopup(in: self, draggable: true, preferedHeight: view.frame.height * 0.7)
    }
    
}
