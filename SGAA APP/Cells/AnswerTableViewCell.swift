//
//  AnswerTableViewCell.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 09/10/2022.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(txt: String, isSelected: Bool) {
        txtLabel.text = txt
        selectedImageView.image = isSelected ? UIImage(named: "ic-radio-check") : UIImage(named: "ic-radio-uncheck")
    }
}
