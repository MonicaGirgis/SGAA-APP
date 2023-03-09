//
//  SubmitView.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 10/10/2022.
//

import UIKit

class SubmitView: UIView {

    @IBOutlet var contentView: UIView!
   
    var didSubmit: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("SubmitView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func submitAction(_ snder: Any) {
        
    }
}
