//
//  historicalModel.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation
import ObjectMapper
import RealmSwift

class HistoricalModel : Object, Mappable, Codable {
    
    @objc dynamic var date: String = ""
    @objc dynamic var date_js: String = ""
    @objc dynamic var smartWealthValue: Int = 0
    @objc dynamic var benchmarkValue: Int = 0

   override init(){
        
    }
    
    required init?(map: ObjectMapper.Map) {
        date <- map["date"]
        date_js <- map["date_js"]
        smartWealthValue <- map["smartWealthValue"]
        benchmarkValue <- map["benchmarkValue"]

    }
    
    func mapping(map: ObjectMapper.Map) {

    }
}
