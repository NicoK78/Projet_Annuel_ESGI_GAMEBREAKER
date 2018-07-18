//
//  Player.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 12/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Player :  Mappable {
    
    init(){}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["idplayer"]
        name <- map["user.last_name"]
        firstname <- map["user.first_name"]
        strongFoot <- map["foot"]
        mobile <- map["phone"]
        email <- map["mail"]
        city <- map["city"]
        poste <- map["position"]
    }
    
    func toJSON() -> [String: Any] {
        return [
            "firstname": firstname as Any,
            "lastname": name as Any,
            "position": poste as Any,
            "foot" : strongFoot as Any,
            "phone" : mobile as Any,
            "mail" : email as Any,
            "team" : idTeam as Any
            //"foot" : strongFoot as Any
        ]
    }
    
    var id :Int!
    var firstname : String!
    var name : String!
    var birhtDate = Date()
    var poste : String!
    var strongFoot :String!
    var mobile : String!
    var email :String!
    var city : String!
    var idTeam : Int!
}
//import Foundation
//
//class Player {
//
//    var firstname = ""
//    var lastname = ""
//    var number = 0
//
//
//    init(firstname: String, lastname: String, number: Int) {
//        self.firstname = firstname
//        self.lastname = lastname
//        self.number = number
//    }
//}
