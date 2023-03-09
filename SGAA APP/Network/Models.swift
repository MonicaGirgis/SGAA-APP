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
    let text: String?
    let correct: Bool?
    let id: Int?
    let answerText: String?
    let selected: Bool?
}

struct AnswersModel {
    var questionId: Int
    var answerId: Int
}

struct Profile : Codable {
    let student : Student
    let pastSevenDaysAnswerCount : [Int]?
    let sameClassStudents : [SameClassStudents]?
    let level : Int
    let nextLevel : Int?
    let progress : Int
    let totalReadings : Int
    let totalQuestions : Int
    let rightAnswersPercentage : Int
}

struct AcademicGroup : Codable {
    let name : String?
    let id : Int?
}

struct Class : Codable {
    let name : String?
    let academicGroupId : Int?
    let academicGroup : AcademicGroup?
    let id : Int?
}

struct SameClassStudents : Codable {
    let studentId : Int?
    let studentName : String?
    let score : Int?
    let className : String?
}

struct Student : Codable {
    let name : String?
    let gender : String?
    let mobile : String?
    let birthdate : String?
    let classId : Int?
    let myClass : Class
    let className : String
    let userId : Int?
    let username : String?
    let score : Int?
    let coins : Int?
    let codeX : String?
    let familyId : Int?
    let familyName : String?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case gender = "gender"
        case mobile = "mobile"
        case birthdate = "birthdate"
        case classId = "classId"
        case myClass = "class"
        case className = "className"
        case userId = "userId"
        case username = "username"
        case score = "score"
        case coins = "coins"
        case codeX = "codeX"
        case familyId = "familyId"
        case familyName = "familyName"
        case id = "id"
    }
}

struct History: Decodable {
    let questionText: String
    let questionDate: String
    let answers: [Answer]
}
