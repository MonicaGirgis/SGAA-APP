//
//  String+Extensions.swift
//  FFLASHH
//
//  Created by Mina Malak on 22/05/2021.
//

import Foundation

extension String {
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getDate(fromFormat: String? = nil, toFormat: String? = nil) -> String {
        var res = ""
        if self.count == "2022-01-06T02:10:25".count {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_DZ") as Locale
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //21
            if let fromFormat = fromFormat {
                dateFormatter.dateFormat = fromFormat
            }
            let theDate = dateFormatter.date(from: self)
            
            dateFormatter.dateFormat = "EEE, dd MMM yyyy"//"EEE, MMM d, yyyy"
            if let toFormat = toFormat {
                dateFormatter.dateFormat = toFormat
            }
            res =  dateFormatter.string(from: theDate!)
            
        }else if self != "" {
            res = self
        }
        
        return res
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func dateFormat()-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let newFormat = DateFormatter()
        newFormat.dateFormat = "hh:mm a"
        newFormat.amSymbol = "AM".localized
        newFormat.pmSymbol = "PM".localized
        if let date = formatter.date(from: self){
            return newFormat.string(from: date)
        }
        return ""
    }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

// MARK: - extension Date
extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var weekLater: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 5, to: sunday)
    }
    
    func getStringValue(with format: String? = nil) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_DZ") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let format = format {
            dateFormatter.dateFormat = format
        }
        
        return dateFormatter.string(from: self)
    }
    
    func getDateAfter(with count: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: count, to: self)!
    }
}
