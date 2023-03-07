//
//  HeaderOfQuestion.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import UIKit

class HeaderOfQuestion: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var txtLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("HeaderOfQuestion", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    func setData(text: String) {
        txtLabel.text = text
    }
    
}
