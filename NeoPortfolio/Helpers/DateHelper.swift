//
//  DateHelper.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation

extension String {
    
    func toDate (format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
       return dateFormatter.date(from: self)!
    }
    

}

extension Date {
    
    func toDateString(format: String) -> String {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = format
        return dateStringFormatter.string(from: self)
    }


}
