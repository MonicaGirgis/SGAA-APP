//
//  Helper.swift
//  customer
//
//  Created by Monica Girgis Kamel on 15/01/2022.
//

import UIKit


let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let windows = windowScene?.windows.first
let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

internal func createActivityIndicator(_ uiview: UIView)->UIView{
    guard windows != nil else { return UIView()}
    let container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiview.frame.size
    container.center = windows!.center
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = CGPoint(x: uiview.frame.width/2, y: uiview.frame.height/2)
    loadingView.backgroundColor = .white //UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.gray.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.style = UIActivityIndicatorView.Style.large
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    windows!.addSubview(container)
    actInd.startAnimating()
    
    return container
    
}
