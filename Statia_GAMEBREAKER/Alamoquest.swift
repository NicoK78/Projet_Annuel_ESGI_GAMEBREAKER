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
    
    static let baseURL = "http://localhost:8000/api/"
    
    let headers: HTTPHeaders = [
        "X-CSRFToken": "TjoxdRteZJJtL6K1wCk6xcBq4QyBz8LORRttJcf5OkOLgvxNlHsAthSt1cC8Gtrm",
        "Content-Type": "application/json"
    ]
    
    class func login(parameter:Parameters , completionHandler: @escaping (_ analyst:Analyst) -> Void){
        
        Alamofire.request(baseURL+"login/", method: .post, parameters: parameter, encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Analyst>) in
            let analyst = response.result.value
            print(analyst?.toJSON() as Any)
            if let analyst = analyst {
                completionHandler(analyst)
            } else {
                let wrongAnalyst = Analyst()
                wrongAnalyst.id = -1
                completionHandler(wrongAnalyst)
            }
        }
    }
    
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
        statsTeam.idAnalyst = UserDefaults.standard.integer(forKey: "idAnalyst")
        print(statsTeam.toJSON())
        Alamofire.request(baseURL+"statsmatch/", method: .post, parameters: statsTeam.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<StatsTeam>) in
            let statsTeam = response.result.value
            
            if let statsTeam = statsTeam {
                completionHandler(statsTeam)
            }
        }
    }
    
    class func postMatchEventPlayer(matchEventPlayer: MatchEventPlayer, completionHandler: @escaping (_ matchEventPlayer: MatchEventPlayer) -> Void) {
        Alamofire.request(baseURL+"matcheventplayer/", method: .post, parameters: matchEventPlayer.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<MatchEventPlayer>) in
            let matchEventPlayer = response.result.value
            
            if let matchEventPlayer = matchEventPlayer {
                completionHandler(matchEventPlayer)
            }
        }
    }
    
    class func postAllEvents(allEvents: [[String: Any]]) {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: allEvents)
        let url = URL(string: baseURL+"matcheventplayer/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        Alamofire.request(request).responseJSON(completionHandler: { (response) in
            print(response)
        })
    }
    
    class func updateMatch(match: Match) {
        Alamofire.request(baseURL+"matchs/\(match.id)").responseObject{ (response: DataResponse<Match>) in
            let aMatch = response.result.value
            
            if let aMatch = aMatch {
                aMatch.state = match.state
                aMatch.homeGoal = match.homeGoal
                aMatch.awayGoal = match.awayGoal
                Alamofire.request(baseURL+"matchs/\(aMatch.id)/", method: .put, parameters: aMatch.toJSON(), encoding: URLEncoding.httpBody).responseObject { (response:DataResponse<Match>) in
                    
                }
            }
        }
    }
}
