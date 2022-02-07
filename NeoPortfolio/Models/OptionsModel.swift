//
//  LoginModel.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/21/21.
//

import Foundation
import ObjectMapper
import RealmSwift

class OptionsModel : Object, Mappable, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var short_description: String = ""
    @objc dynamic var risk_score: Int = 0
    @objc dynamic var isSelected: Bool = false

   override init(){
        
    }
    private enum CodingKeys: String, CodingKey {
         case id, name, short_description, risk_score
     }
    override static func ignoredProperties() -> [String] {
      return ["isSelected"]
    }
    required init?(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        short_description <- map["short_description"]
        risk_score <- map["risk_score"]

    }
    
    func mapping(map: ObjectMapper.Map) {

    }
}
