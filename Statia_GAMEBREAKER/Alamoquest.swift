//
//  Alamoquest.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 17/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

public class Alamoquest{
    
    let headers: HTTPHeaders = [
        "X-CSRFToken": "TjoxdRteZJJtL6K1wCk6xcBq4QyBz8LORRttJcf5OkOLgvxNlHsAthSt1cC8Gtrm",
        "Content-Type": "application/json"
    ]
    
    class func getMatchToAnalyze(completionHandler: @escaping (_ matchs: [Match]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/matchtoanalyze").responseArray { (response: DataResponse<[Match]>) in
            let matchs = response.result.value
            
            if let matchs = matchs {
                print("REQUEST : \(matchs.toJSON())")
                completionHandler(matchs)
            }
        }
    }
    
    class func getPlayerByTeam(id: Int, completionHandler: @escaping (_ teams: [Player]) -> Void) {
        Alamofire.request("http://127.0.0.1:8000/api/playersbyteam/\(id)").responseArray { (response: DataResponse<[Player]>) in
            
            let players = response.result.value
            
            if let player = players {
                completionHandler(player)
            }
        }
    }
    
    class func postStatsMatchForTeam(statsTeam: StatsTeam, completionHandler: @escaping (_ statsTeam: StatsTeam) -> Void) {
        Alamofire.request("http://localhost:8000/api/statsmatch/", method: .post, parameters: statsTeam.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<StatsTeam>) in
            let statsTeam = response.result.value
            
            if let statsTeam = statsTeam {
                completionHandler(statsTeam)
            }
        }
    }
    
    class func postMatchEventPlayer(matchEventPlayer: MatchEventPlayer, completionHandler: @escaping (_ matchEventPlayer: MatchEventPlayer) -> Void) {
        Alamofire.request("http://localhost:8000/api/matcheventplayer/", method: .post, parameters: matchEventPlayer.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<MatchEventPlayer>) in
            let matchEventPlayer = response.result.value
            
            if let matchEventPlayer = matchEventPlayer {
                completionHandler(matchEventPlayer)
            }
        }
    }
}
