//
//  LoginViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 27/08/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: mainView.frame.width/2)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabControllers")
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}
