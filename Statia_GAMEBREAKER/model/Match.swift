//
//  Match.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 12/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class Match : Mappable {
    
    init() {}
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["idmatch"]
        home <- map["home"]
        away <- map["away"]
        tournament <- map["tournament"]
        date <- map["date"]
        homeGoal <- map["home_goal"]
        awayGoal <- map["away_goal"]
        state <- map["state"]
    }
    
    
    func toJSON() -> [String: Any] {
        return [
            "idmatch" : id as Any,
            "home": home.id as Any,
            "away": away.id as Any,
            "tournament": tournament.id as Any,
            "date" : date as Any,
            "home_goal" : homeGoal as Any,
            "away_goal" : awayGoal as Any,
            "state" : state as Any
        ]
    }
    
    func toJsonCreate() -> [String: Any] {
        return [
            "home": home.id as Int,
            "away": away.id as Int,
            "tournament": tournament.id as Int,
            "date" : date as String
        ]
    }
    
    var id = Int()
    var home = Team()
    var away = Team()
    var tournament = Competition()
    var date = String()
    var day = Int()
    var homeGoal = Int()
    var awayGoal = Int()
    var state = Int()
    
    
    
}
//import Foundation
//
//class Match {
//    
//    var home: Team
//    var away: Team
//    
//    init(home: Team, away: Team) {
//        
//        self.home = home
//        self.away = away
//        
//    }
//}
