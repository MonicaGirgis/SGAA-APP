//
//  UiViewController + Ext.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import Foundation
import STPopup

var sharedPopupController: STPopupController?

extension UIViewController {
    
    @objc func closeAction(sender: UIBarButtonItem) {
        sharedPopupController?.dismiss()
        sharedPopupController = nil
    }
    
    @objc func popAction(sender: UIBarButtonItem) {
        sharedPopupController?.popViewController(animated: true)
    }
    
    @discardableResult
    func presentAsActionSheetPopup(in parent: UIViewController, draggable: Bool = true, preferedHeight: CGFloat) -> STPopupController {
        contentSizeInPopup = CGSize(width: 0, height: preferedHeight)
        let popupController = STPopupController(rootViewController: self)
        popupController.containerView.layer.cornerRadius = 16
        popupController.style = .bottomSheet
        popupController.navigationBar.barTintColor = .black
        popupController.navigationBar.backgroundColor = .black
        popupController.backgroundView?.backgroundColor = .black
        popupController.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let rightNavBarBtnItem  = UIBarButtonItem(image: UIImage(named: "ic-close"), style: .plain, target: self, action: #selector(closeAction))
        rightNavBarBtnItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightNavBarBtnItem
        popupController.navigationBar.draggable = draggable
        popupController.present(in: parent)
        sharedPopupController = popupController
        return popupController
    }
}
