//
//  PortfolioModel.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import Foundation
import ObjectMapper
import RealmSwift

class PortfolioModel : Object, Mappable, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var created_at: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var balance: Int = 0
    @objc dynamic var total_earnings: Int = 0
    @objc dynamic var latest_daily_earning: Int = 0
    @objc dynamic var modified_risk_score: Int = 0
    @objc dynamic var investment_type: String = ""

   override init(){
        
    }
    
    required init?(map: ObjectMapper.Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        name <- map["name"]
        balance <- map["balance"]
        total_earnings <- map["total_earnings"]
        latest_daily_earning <- map["latest_daily_earning"]
        modified_risk_score <- map["modified_risk_score"]
        investment_type <- map["investment_type"]

        
    }
    func mapping(map: ObjectMapper.Map) {
        
    }
}
