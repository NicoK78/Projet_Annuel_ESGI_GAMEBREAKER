//
//  StatsTeam.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 11/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import ObjectMapper

class StatsTeam : Mappable {
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    var id :Int?
    var idTeam :Int!
    var idMatch :Int!
    var team: Team?
    var match: Match?
    var possession = 50
    // Players Stats
    var passSucceed = 0
    var passFailed = 0
    var duelWin = 0
    var duelLost = 0
    var centerSucceed = 0
    var centerFailed = 0
    var shotIn = 0
    var shotOut = 0
    var shotCountered = 0
    var cornerObtained = 0
    var ballConceded = 0
    var offSide = 0
    var interception = 0
    var foul = 0
    var penalty = 0
    var clearance = 0
    
    // Goalkeeper Stats
    var ballCaptured = 0
    var ballRepeled = 0
    var airInterceptSuccess = 0
    var footInterceptSuccess = 0
    var airInterceptFail = 0
    var footInterceptFail = 0
    
    
    var goalInGame: Array<MatchEventPlayer>
    var goalInGameLastPass: Array<MatchEventPlayer>
    var goalFreekick: Array<MatchEventPlayer>
    var goalPenalty: Array<MatchEventPlayer>
    var goalAgainst: Array<MatchEventPlayer>
    var yellowCard: Array<MatchEventPlayer>
    var redCard: Array<MatchEventPlayer>
    
    var goalEvent: Array<MatchEventPlayer>
    
    init() {
        
        self.goalInGame = []
        self.goalInGameLastPass = []
        self.goalFreekick = []
        self.goalPenalty = []
        self.goalAgainst = []
        self.yellowCard = []
        self.redCard = []
        
        self.goalEvent = []
    }
    
    func mapping(map: Map) {
        id <- map["idStatistiquesMatch"]
        idMatch <- map["match"]
        idTeam <- map["team"]
        possession <- map["possession"]
        passSucceed <- map["passe_reussie"]
        passFailed <- map["passe_ratee"]
        duelWin <- map["duel_gagne"]
        duelLost <- map["duel_perdu"]
        centerSucceed <- map["centre_reussi"]
        centerFailed <- map["centre_rate"]
        shotIn <- map["tir_cadre"]
        shotOut <- map["tir_hors_cadre"]
        shotCountered <- map["tir_contre"]
        cornerObtained <- map["corner_obtenu"]
        ballConceded <- map["ballon_concede"]
        offSide <- map["hors_jeu"]
        interception <- map["interception"]
        foul <- map["faute_commise"]
        penalty <- map["penalty_commis"]
        clearance <- map["degagement"]
    }
    
    func toJSON() -> [String: Any] {
        return [
            "idStatistiquesMatch": id,
            "match": idMatch,
            "team": idTeam,
            "possession": possession,
            "passe_reussie": passSucceed,
            "passe_ratee": passFailed,
            "duel_gagne": duelWin,
            "duel_perdu": duelLost,
            "centre_reussi": centerSucceed,
            "centre_rate": centerFailed,
            "tir_cadre": shotIn,
            "tir_hors_cadre": shotOut,
            "tir_contre": shotCountered,
            "corner_obtenu": cornerObtained,
            "ballon_concede": ballConceded,
            "hors_jeu": offSide,
            "interception": interception,
            "faute_commise": foul,
            "penalty_commis": penalty,
            "degagement": clearance
        ]
    }
}
