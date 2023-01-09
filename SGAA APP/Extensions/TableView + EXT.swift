//
//  TableView + EXT.swift
//  SGAA APP
//
//  Created by Mina Zakaria on 09/10/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: cellClass.self), bundle: nil), forCellReuseIdentifier: String(describing: cellClass.self))
    }
    
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in dequeue cell")
        }
        
        return cell
    }
    
    func registerHeaderNib<Header: UITableViewHeaderFooterView>(headerClass: Header.Type) {
        register(UINib(nibName: String(describing: headerClass.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: headerClass.self))
    }
    
    func dequeueHeader<Header: UITableViewHeaderFooterView>() -> Header {
        let identifier = String(describing: Header.self)
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header else {
            fatalError("Error in dequeue cell")
        }
        return header
    }
}
