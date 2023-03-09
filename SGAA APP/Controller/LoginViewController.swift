//
//  LoginViewController.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 27/08/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private lazy var loader: UIView = {
       return createActivityIndicator(view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: mainView.frame.width/2)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func login(userName: String, password: String) {
        loader.isHidden = true
        APIRoute.shared.fetchRequest(clientRequest: .login(username: userName, password: password), decodingModel: User.self) { [weak self] result in
            self?.loader.isHidden = false
            switch result {
            case .success(let data):
                UserManager.shared.setUserData(user: data)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabControllers")
                vc?.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        guard let name = userNameField.text, !name.isEmpty, let pass = passwordField.text, !pass.isEmpty else { return}
        login(userName: name, password: pass)
    }
}
