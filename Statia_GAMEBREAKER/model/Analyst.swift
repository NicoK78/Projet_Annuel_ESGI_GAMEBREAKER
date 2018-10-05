//
//  Analyst.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 20/09/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Analyst :  Mappable {
    
    init(){}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["idanalyst"]
        name <- map["name"]
        firstname <- map["firstname"]
    }
    
    func toJSON() -> [String: Any] {
        return [
            "idanalyst": id as Any,
            "firstname": firstname as Any,
            "name": name as Any
        ]
    }
    
    var id = Int()
    var firstname = String()
    var name = String()
}
