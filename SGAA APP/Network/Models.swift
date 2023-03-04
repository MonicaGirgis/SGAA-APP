//
//  Models.swift
//  Baquala
//
//  Created by Monica Girgis Kamel on 23/05/2022.
//

import Foundation
import UIKit

struct FlagMessageResponse : Decodable {
    var errors : [String: [String]]?
    var title : String?
}

struct Pagination : Codable {
    let total : Int?
    let count : Int?
    let per_page : Int?
    let current_page : Int?
    let total_pages : Int?
}

struct PaginationResponse<T : Decodable> : Decodable {
    var data : [T]?
    var pagination : Pagination?
}


////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///

struct User: Decodable {
    let userId: Int
    let token: String
    let expiresIn: Int
}
