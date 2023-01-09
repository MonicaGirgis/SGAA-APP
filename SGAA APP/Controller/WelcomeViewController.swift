//
//  ViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 25/08/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var anbiaButton: UIButton!
    @IBOutlet weak var rosolButton: UIButton!
    @IBOutlet weak var kedsatButton: UIButton!
    @IBOutlet weak var kedsenButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    func setupUI() {
        mainView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: mainView.frame.width/2)
        anbiaButton.layer.cornerRadius = anbiaButton.frame.height / 2
        rosolButton.layer.cornerRadius = rosolButton.frame.height / 2
        kedsatButton.layer.cornerRadius = kedsatButton.frame.height / 2
        kedsenButton.layer.cornerRadius = kedsenButton.frame.height / 2
    }
    
    @IBAction func didSelectAnbiaButton(_ sender: UIButton) {
        
//        let loginVc = LoginViewController()
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func didSelectRosolButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        _ = vc?.presentAsActionSheetPopup(in: self, draggable: true, preferedHeight: view.frame.height * 0.7)
    }
    
    @IBAction func didSelectKedsatButton(_ sender: UIButton) {
    }
    
    @IBAction func didSelectKedsenButton(_ sender: UIButton) {
    }
    
}
