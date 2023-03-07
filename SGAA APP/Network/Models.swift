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

struct Reading: Decodable {
    let questions: [Question]
    let id: Int
    let chapter: String
    let date: String
    let context: String
}

struct Question: Decodable {
    let id: Int
    let text: String
    let answers: [Answer]
}

struct Answer: Decodable {
    let text: String
    let correct: Bool
    let id: Int
}

struct AnswersModel {
    var questionId: Int
    var answerId: Int
}
