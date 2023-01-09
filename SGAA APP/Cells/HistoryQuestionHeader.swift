//
//  HistoryQuestionHeader.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 11/10/2022.
//

import UIKit

class HistoryQuestionHeader: UIView {
    @IBOutlet weak var contentView: UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("HistoryQuestionHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
