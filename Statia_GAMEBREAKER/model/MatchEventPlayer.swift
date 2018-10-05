//
//  MatchEvent.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 16/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

enum MatchEvents {
    case goalInGame
    case goalFreekick
    case goalPenalty
    case goalAgainst
    case yellowCard
    case redCard
    case ballCapted
    case ballPushed
    case airInterceptionSucceed
    case footInterceptionSucceed
    case airInterceptionFailed
    case footInterceptionFailed
    case lastPass
}

class MatchEventPlayer: Mappable {
    
    var player = Player()
    var lastPass = Player()
    var matchEvent: MatchEvents?
    
    var idMatchEvent = Int()
    var idStatsMatch = Int()
    var idPlayer = Int()
    var minute = Int()
    var event = String()
    
    init() {}
    init(player: Player, matchEvent: MatchEvents, minute: Int) {
        self.player = player
        self.idPlayer = (player.id)
        print("TEST ID : \(player.id) \(player.id) - \(self.idPlayer) \(self.idPlayer)")
        self.minute = minute
        
        self.matchEvent = matchEvent
        switch matchEvent {
        case .goalInGame:
            event = "But dans le jeu"
            break
        case MatchEvents.goalFreekick:
            event = "But sur CPA"
            break
        case MatchEvents.goalPenalty:
            event = "But sur penalty"
            break
        case MatchEvents.goalAgainst:
            event = "CSC adverse"
            break
        case MatchEvents.yellowCard:
            event = "Carton jaune"
            break
        case MatchEvents.redCard:
            event = "Carton rouge"
            break
        case MatchEvents.ballCapted:
            event = "Ballon capté"
            break
        case MatchEvents.ballPushed:
            event = "Ballon repoussé"
            break
        case MatchEvents.airInterceptionSucceed:
            event = "Interception aérienne"
            break
        case MatchEvents.footInterceptionSucceed:
            event = "Interception dans les pieds"
            break
        case MatchEvents.airInterceptionFailed:
            event = "Interception aérienne ratée"
            break
        case MatchEvents.footInterceptionFailed:
            event = "Interception dans les pieds ratée"
            break
        case MatchEvents.lastPass:
            event = "Passe décisive"
            break
        }
    }
    
    func mapping(map: Map) {
        idMatchEvent <- map["idMatchEvent"]
        idStatsMatch <- map["statsMatch"]
        idPlayer <- map["player"]
        minute <- map["minute"]
        event <- map["event"]
    }
    
    func toJSON() -> [String: Any] {
        return [
//            "idMatchEvent": idMatchEvent,
            "statsMatch": idStatsMatch,
            "player": idPlayer,
            "minute": minute,
            "event": event
        ]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}
