//
//  GameBreakerViewController.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 23/06/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SwiftyJSON
//import SwiftyPickerPopover

class GameBreakerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    // Boolean for the type of popups
    var isGoalAction = false
    var isPassAndGoal = false
    var indexAction = -1
    // Elements for Popups
    var textfieldPlayer: UITextField!
    var indexFirstTF = -1
    var textfieldLastPass: UITextField!
    var indexSecondTF = -1
    var textfieldMinutes: UITextField!
    
    let goalActions = ["Ballon capté", "Ballon repoussé", "Interception aérienne", "Interception dans les pieds", "Interception aérienne ratée", "Interception dans les pieds ratée"]
    
    var isPrimaryTF = true
    
    let pickerView = UIPickerView()
    
    
    // PICKERVIEW FUNCTIONS
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(self.isPassAndGoal || self.isGoalAction) {
            return 2
        } else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            if(!self.switchTeam.isOn) {
                return homePlayers.count
            } else {
                return awayPlayers.count
            }
        } else if(component == 1 && !self.isGoalAction) {
            if(!self.switchTeam.isOn) {
                return homePlayers.count+1
            } else {
                return awayPlayers.count+1
            }
        } else {
            return goalActions.count
        }
    }
    // This function sets the text of the picker view to the content of the array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0 || (component == 1 && !self.isGoalAction)) {
            if(component == 0) {
                if(!self.switchTeam.isOn) {
                    return ("\(String(describing: (homePlayers[row].firstname))) \(String(describing: (homePlayers[row].name)))")
                } else {
                    return ("\(String(describing: (awayPlayers[row].firstname))) \(String(describing: (awayPlayers[row].name)))")
                }
            } else if(component == 1 && row == 0) {
                return ("NO ASSIST")
            } else {
                if(!self.switchTeam.isOn) {
                    return ("\(String(describing: (homePlayers[row-1].firstname))) \(String(describing: (homePlayers[row-1].name)))")
                } else {
                    return ("\(String(describing: (awayPlayers[row-1].firstname))) \(String(describing: (awayPlayers[row-1].name)))")
                }
            }
        } else {
            return goalActions[row]
        }
    }
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0) {
            if(!self.switchTeam.isOn) {
                textfieldPlayer.text = "\(String(describing: (homePlayers[row].firstname))) \(String(describing: (homePlayers[row].name)))"
            } else {
                textfieldPlayer.text = ("\(String(describing: (awayPlayers[row].firstname))) \(String(describing: (awayPlayers[row].name)))")
            }
            indexFirstTF = row
        } else {
            if(self.isGoalAction) {
                textfieldLastPass.text = goalActions[row]
                indexSecondTF = row
            } else {
                if(row == 0) {
                    textfieldLastPass.text = nil
                    indexSecondTF = -1
                } else {
                    if(!self.switchTeam.isOn) {
                        textfieldLastPass.text = "\(String(describing: (homePlayers[row-1].firstname))) \(String(describing: (homePlayers[row-1].name)))"
                    } else {
                        textfieldLastPass.text = ("\(String(describing: (awayPlayers[row-1].firstname))) \(String(describing: (awayPlayers[row-1].name)))")
                    }
                    indexSecondTF = row-1
                }
            }
        }
    }
    
    
    var homeTeam: Team?
    var awayTeam: Team?
    // Teams Stats in match
    var homeStats: StatsTeam?
    var awayStats: StatsTeam?
    /*
     **  BUTTONS AND LABELS
     */
    @IBOutlet var home: UILabel!
    @IBOutlet var away: UILabel!
    @IBOutlet var switchTeam: UISwitch!
    
    @IBOutlet var passSucceed: UILabel!
    @IBAction func passSucceed(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.passSucceed += 1
        } else {
            awayStats?.passSucceed += 1
        }
        passSucceed.text = String(Int(passSucceed.text!)! + 1)
    }
    @IBOutlet var passFailed: UILabel!
    @IBAction func passFailed(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.passFailed += 1
        } else {
            awayStats?.passFailed += 1
        }
        passFailed.text = String(Int(passFailed.text!)! + 1)
    }
    
    @IBOutlet var duelWin: UILabel!
    @IBAction func duelWin(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.duelWin += 1
        } else {
            awayStats?.duelWin += 1
        }
        duelWin.text = String(Int(duelWin.text!)! + 1)
    }
    @IBOutlet var duelLost: UILabel!
    @IBAction func duelLost(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.duelLost += 1
        } else {
            awayStats?.duelLost += 1
        }
        duelLost.text = String(Int(duelLost.text!)! + 1)
    }
    
    @IBOutlet var centerSucceed: UILabel!
    @IBAction func centerSucceed(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.centerSucceed += 1
        } else {
            awayStats?.centerSucceed += 1
        }
        centerSucceed.text = String(Int(centerSucceed.text!)! + 1)
    }
    @IBOutlet var centerFailed: UILabel!
    @IBAction func centerFailed(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.centerFailed += 1
        } else {
            awayStats?.centerFailed += 1
        }
        centerFailed.text = String(Int(centerFailed.text!)! + 1)
    }
    
    @IBOutlet var shotIn: UILabel!
    @IBAction func shotIn(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.shotIn += 1
        } else {
            awayStats?.shotIn += 1
        }
        shotIn.text = String(Int(shotIn.text!)! + 1)
    }
    @IBOutlet var shotOut: UILabel!
    @IBAction func shotOut(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.shotOut += 1
        } else {
            awayStats?.shotOut += 1
        }
        shotOut.text = String(Int(shotOut.text!)! + 1)
    }
    @IBOutlet var shotCountered: UILabel!
    @IBAction func shotCountered(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.shotCountered += 1
        } else {
            awayStats?.shotCountered += 1
        }
        shotCountered.text = String(Int(shotCountered.text!)! + 1)
    }
    
    @IBOutlet var goalInGame: UILabel!
    @IBAction func goalInGame(_ sender: Any) {
        indexAction = 0
        isPassAndGoal = true
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var goalFreekick: UILabel!
    @IBAction func goalFreekick(_ sender: Any) {
        indexAction = 1
        isPassAndGoal = true
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var goalPenalty: UILabel!
    @IBAction func goalPenalty(_ sender: Any) {
        indexAction = 2
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var goalAgainst: UILabel!
    @IBAction func goalAgainst(_ sender: Any) { //CSC
        indexAction = 3
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var cornerObtained: UILabel!
    @IBAction func cornerObtained(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.cornerObtained += 1
        } else {
            awayStats?.cornerObtained += 1
        }
        cornerObtained.text = String(Int(cornerObtained.text!)! + 1)
    }
    
    @IBOutlet var ballConceded: UILabel!
    @IBAction func ballConceded(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.ballConceded += 1
        } else {
            awayStats?.ballConceded += 1
        }
        ballConceded.text = String(Int(ballConceded.text!)! + 1)
    }
    
    @IBOutlet var offSide: UILabel!
    @IBAction func offSide(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.offSide += 1
        } else {
            awayStats?.offSide += 1
        }
        offSide.text = String(Int(offSide.text!)! + 1)
    }
    
    @IBOutlet var interception: UILabel!
    @IBAction func interception(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.interception += 1
        } else {
            awayStats?.interception += 1
        }
        interception.text = String(Int(interception.text!)! + 1)
    }
    
    @IBOutlet var foul: UILabel!
    @IBAction func foul(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.foul += 1
        } else {
            awayStats?.foul += 1
        }
        foul.text = String(Int(foul.text!)! + 1)
    }
    
    @IBOutlet var penalty: UILabel!
    @IBAction func penalty(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.penalty += 1
        } else {
            awayStats?.penalty += 1
        }
        penalty.text = String(Int(penalty.text!)! + 1)
    }
    
    @IBOutlet var yellowCard: UILabel!
    @IBAction func yellowCard(_ sender: Any) {
        indexAction = 4
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var redCard: UILabel!
    @IBAction func redCard(_ sender: Any) {
        indexAction = 5
        playerAction(title: "Choisissez un joueur", message: "Quel joueur a fait cette action ?")
    }
    
    @IBOutlet var clearance: UILabel!
    @IBAction func clearance(_ sender: Any) {
        if(!switchTeam.isOn) {
            homeStats?.clearance += 1
        } else {
            awayStats?.clearance += 1
        }
        clearance.text = String(Int(clearance.text!)! + 1)
    }
    
    @IBAction func goalAction(_ sender: Any) {
        indexAction = 6
        isGoalAction = true
        playerAction(title: "Choisissez une action", message: "Action du gardien")
    }
    
    
    // SHOW A POPUP FOR SELECT THE PLAYER
    func playerAction(title: String, message: String) {
        // 1
        let selectPlayerController: UIAlertController
        selectPlayerController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // 2
        let selectAction = UIAlertAction(title: "Valider", style: UIAlertActionStyle.default) { (action:UIAlertAction) -> Void in
            
            let minutesTextField = selectPlayerController.textFields![0]
            let playerTextField = selectPlayerController.textFields![1]
            let lastPassTextField: UITextField
            let secondPlayer: Player?
            
            var teamPlayers: Array<Player>
            if (!self.switchTeam.isOn) {
                teamPlayers = self.homePlayers
            } else {
                teamPlayers = self.awayPlayers
            }
            
            if(self.isPassAndGoal) {
                lastPassTextField = selectPlayerController.textFields![2]
                
                if(lastPassTextField.text == "") {
                    secondPlayer = nil
                } else {
                    secondPlayer = (teamPlayers[self.indexSecondTF])
                }
            } else {
                secondPlayer = nil
            }
            
            self.setMatchEvent(player: (teamPlayers[self.indexFirstTF]), minutes: Int(minutesTextField.text!)!, secondPlayer: secondPlayer)
            
            self.isGoalAction = false
            self.isPassAndGoal = false
            self.indexAction = -1
            self.indexFirstTF = -1
            self.indexSecondTF = -1
            self.isPrimaryTF = true
            
            if(!self.switchTeam.isOn) {
                self.setValues(teamStats: self.homeStats)
            } else {
                self.setValues(teamStats: self.awayStats)
            }
        }
        // 3
        let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.default) { (action:UIAlertAction) -> Void in
            
            self.isGoalAction = false
            self.isPassAndGoal = false
            self.indexAction = -1
            self.indexFirstTF = -1
            self.indexSecondTF = -1
            self.isPrimaryTF = true
        }
        
        // 4
        selectPlayerController.addTextField { (textField:UITextField!) -> Void in
            
            textField.placeholder = "Minutes"
            
            textField.keyboardType = UIKeyboardType.numberPad
            
            self.textfieldMinutes = textField
            
        }
        selectPlayerController.addTextField { (textField:UITextField!) -> Void in
            
            if(self.isGoalAction) {
                textField.placeholder = "Gardien"
            } else if(self.isPassAndGoal) {
                textField.placeholder = "Buteur"
            } else {
                textField.placeholder = "Joueur"
            }
            
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.sizeToFit()
            
            toolBar.isUserInteractionEnabled = true
            
            textField.inputView = self.pickerView
            textField.inputAccessoryView = toolBar
            self.textfieldPlayer = textField
            
            textField.resignFirstResponder()
        }
        if(self.isPassAndGoal || self.isGoalAction) {
            selectPlayerController.addTextField { (textField2:UITextField!) -> Void in
                
                if(self.isPassAndGoal) {
                    textField2.placeholder = "Passeur décisif"
                } else if(self.isGoalAction) {
                    textField2.placeholder = "Action"
                }
                self.textfieldLastPass = textField2
                
            }
        }
        selectPlayerController.addAction(selectAction)
        selectPlayerController.addAction(cancelAction)
        // 7
        present(selectPlayerController, animated: true, completion: nil)
    }
    @objc func changeTF() {
        self.isPrimaryTF = false
    }
    
    var homePlayers: Array<Player> = []
    var awayPlayers: Array<Player> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        home.text = homeTeam?.name
        away.text = awayTeam?.name
        
        switchTeam.addTarget(self, action: #selector(stateChanged), for: UIControlEvents.valueChanged)
        switchTeam.isOn = false
        
        self.navigationController?.isToolbarHidden = false
        
        var items = [UIBarButtonItem]()
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(add)) ) // replace add with your function
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        
        self.toolbarItems = items // this made the difference. setting the items to the controller, not the navigationcontroller
        
        // TODO : Récupérer joueurs de la composition
        Alamoquest.getPlayerByTeam(id: (homeTeam?.id)!) { (players) in
            for player in players {
                self.homePlayers.append(player)
            }
        }
        Alamoquest.getPlayerByTeam(id: (awayTeam?.id)!) { (players) in
            for player in players {
                self.awayPlayers.append(player)
            }
        }
        
        setValues(teamStats: homeStats)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        passSucceed.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        passFailed.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        duelWin.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        duelLost.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        centerSucceed.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        centerFailed.addGestureRecognizer(tap5)
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        shotIn.addGestureRecognizer(tap6)
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        shotOut.addGestureRecognizer(tap7)
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        shotCountered.addGestureRecognizer(tap8)
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        cornerObtained.addGestureRecognizer(tap9)
        let tap10 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        ballConceded.addGestureRecognizer(tap10)
        let tap11 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        offSide.addGestureRecognizer(tap11)
        let tap12 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        interception.addGestureRecognizer(tap12)
        let tap13 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        foul.addGestureRecognizer(tap13)
        let tap14 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        penalty.addGestureRecognizer(tap14)
        let tap15 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        clearance.addGestureRecognizer(tap15)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        var label: UILabel
        label = sender.view as! UILabel
        
        let tmpLabel = self.view.viewWithTag(label.tag) as? UILabel
        var tmpTeam: StatsTeam
        tmpTeam = (switchTeam.isOn ? awayStats : homeStats)!
        
        if(tmpLabel!.text != "0") {
            tmpLabel!.text = String(Int(tmpLabel!.text!)! - 1)
            
            switch label.tag {
            case 1:
                tmpTeam.passSucceed -= 1
            case 2:
                tmpTeam.passFailed -= 1
            case 3:
                tmpTeam.duelWin -= 1
            case 4:
                tmpTeam.duelLost -= 1
            case 5:
                tmpTeam.centerSucceed -= 1
            case 6:
                tmpTeam.centerFailed -= 1
            case 7:
                tmpTeam.shotIn -= 1
            case 8:
                tmpTeam.shotOut -= 1
            case 9:
                tmpTeam.shotCountered -= 1
            case 10:
                tmpTeam.cornerObtained -= 1
            case 11:
                tmpTeam.ballConceded -= 1
            case 12:
                tmpTeam.offSide -= 1
            case 13:
                tmpTeam.interception -= 1
            case 14:
                tmpTeam.foul -= 1
            case 15:
                tmpTeam.penalty -= 1
            case 16:
                tmpTeam.clearance -= 1
            default:
                print("NOTHING")
            }
            
        }
        
    }
    
    // SAVE STATS OF BOTH TEAMS THEN BACK TO SELECTMATCH VIEW
    @objc func add() {
        let alert = UIAlertController(title: "Avez-vous terminé ?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Valider", style: .default) { (action:UIAlertAction) -> Void in
            
            Alamoquest.postStatsMatchForTeam(statsTeam: self.homeStats!, completionHandler: { (statsTeam) in
                print("###### START POST ######")
                
                // SEND PLAYER EVENTS FOR HOMETEAM
                var events: Array<MatchEventPlayer>
                events = (self.homeStats?.goalInGame)! + (self.homeStats?.goalFreekick)! + (self.homeStats?.goalPenalty)! + (self.homeStats?.goalAgainst)!
                events = events + (self.homeStats?.yellowCard)! + (self.homeStats?.redCard)! + (self.homeStats?.goalInGameLastPass)!
                self.sendMatchEvents(events: events, idStatsTeam: statsTeam.id)
                
                // SEND GOAL EVENTS FOR HOMETEAM
                self.sendMatchEvents(events: (self.homeStats?.goalEvent)!, idStatsTeam: statsTeam.id)
            })
            
            Alamoquest.postStatsMatchForTeam(statsTeam: self.awayStats!, completionHandler: { (statsTeam) in
                // SEND PLAYER EVENTS FOR AWAYTEAM
                var events: Array<MatchEventPlayer>
                events = (self.awayStats?.goalInGame)! + (self.awayStats?.goalFreekick)! + (self.awayStats?.goalPenalty)! + (self.awayStats?.goalAgainst)!
                events = events + (self.awayStats?.yellowCard)! + (self.awayStats?.redCard)! + (self.awayStats?.goalInGameLastPass)!
                self.sendMatchEvents(events: events, idStatsTeam: statsTeam.id)
                
                // SEND GOAL EVENTS FOR AWAYTEAM
                self.sendMatchEvents(events: (self.awayStats?.goalEvent)!, idStatsTeam: statsTeam.id)
            })
            
            let goalAway = self.awayStats!.goalInGame.count + self.awayStats!.goalFreekick.count + self.awayStats!.goalPenalty.count + self.homeStats!.goalAgainst.count
            let goalHome = self.homeStats!.goalInGame.count + self.homeStats!.goalFreekick.count + self.homeStats!.goalPenalty.count + self.awayStats!.goalAgainst.count
            let match: Match
            match = (self.homeStats?.match)!
            match.awayGoal = goalAway
            match.homeGoal = goalHome
            match.state = 1
            match.id = (self.homeStats?.idMatch)!
            print("---------- \(match.id)/\((self.homeStats?.idMatch)!) ----------")
            Alamoquest.updateMatch(match: match)
            
            let homeView = SelectMatchViewController(nibName: "SelectMatchViewController", bundle: nil)
            self.navigationController?.pushViewController(homeView, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func sendMatchEvents(events: Array<MatchEventPlayer>, idStatsTeam: Int) {
        var allEvents = [[String: Any]]()
        for e in events {
            e.idStatsMatch = idStatsTeam
            allEvents.append(e.toJSON())
            print(e.toJSON())
        }
        Alamoquest.postAllEvents(allEvents: allEvents)
    }
    
    @objc func stateChanged() {
        if (!switchTeam.isOn) {
            self.home.alpha = 1
            self.away.alpha = 0.5
            setValues(teamStats: homeStats)
        } else {
            self.away.alpha = 1
            self.home.alpha = 0.5
            setValues(teamStats: awayStats)
        }
    }
    
    func setValues(teamStats: StatsTeam?) {
        
        passSucceed.text = "\(teamStats?.passSucceed ?? 0)"
        passFailed.text = "\(teamStats?.passFailed ?? 0)"
        duelWin.text = "\(teamStats?.duelWin ?? 0)"
        duelLost.text = "\(teamStats?.duelLost ?? 0)"
        centerSucceed.text = "\(teamStats?.centerSucceed ?? 0)"
        centerFailed.text = "\(teamStats?.centerFailed ?? 0)"
        shotIn.text = "\(teamStats?.shotIn ?? 0)"
        shotOut.text = "\(teamStats?.shotOut ?? 0)"
        shotCountered.text = "\(teamStats?.shotCountered ?? 0)"
        goalInGame.text = "\(teamStats?.goalInGame.count ?? 0)"
        goalFreekick.text = "\(teamStats?.goalFreekick.count ?? 0)"
        goalPenalty.text = "\(teamStats?.goalPenalty.count ?? 0)"
        goalAgainst.text = "\(teamStats?.goalAgainst.count ?? 0)"
        cornerObtained.text = "\(teamStats?.cornerObtained ?? 0)"
        ballConceded.text = "\(teamStats?.ballConceded ?? 0)"
        offSide.text = "\(teamStats?.offSide ?? 0)"
        interception.text = "\(teamStats?.interception ?? 0)"
        foul.text = "\(teamStats?.foul ?? 0)"
        penalty.text = "\(teamStats?.penalty ?? 0)"
        yellowCard.text = "\(teamStats?.yellowCard.count ?? 0)"
        redCard.text = "\(teamStats?.redCard.count ?? 0)"
        clearance.text = "\(teamStats?.clearance ?? 0)"
        
    }
    
    
    func setMatchEvent(player: Player, minutes: Int, secondPlayer: Player?) {
        var teamStats: StatsTeam
        if (!self.switchTeam.isOn) {
            teamStats = self.homeStats!
        } else {
            teamStats = self.awayStats!
        }
        switch self.indexAction {
        case 0:
            let mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.goalInGame, minute: minutes)
            teamStats.goalInGame.append(mEvent)
            if(secondPlayer != nil) {
                let mEventPass = MatchEventPlayer(player: secondPlayer!, matchEvent: MatchEvents.lastPass, minute: minutes)
                teamStats.goalInGameLastPass.append(mEventPass)
                //                    mEvent.lastPass = secondPlayer!
            }
            break
        case 1:
            let mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.goalFreekick, minute: minutes)
            teamStats.goalFreekick.append(mEvent)
            if(secondPlayer != nil) {
                let mEventPass = MatchEventPlayer(player: secondPlayer!, matchEvent: MatchEvents.lastPass, minute: minutes)
                teamStats.goalInGameLastPass.append(mEventPass)
                //                    mEvent.lastPass = secondPlayer!
            }
            break
        case 2:
            teamStats.goalPenalty.append(MatchEventPlayer(player: player, matchEvent: MatchEvents.goalPenalty, minute: minutes))
            break
        case 3:
            teamStats.goalAgainst.append(MatchEventPlayer(player: player, matchEvent: MatchEvents.goalAgainst, minute: minutes))
            break
        case 4:
            teamStats.yellowCard.append(MatchEventPlayer(player: player, matchEvent: MatchEvents.yellowCard, minute: minutes))
            break
        case 5:
            teamStats.redCard.append(MatchEventPlayer(player: player, matchEvent: MatchEvents.redCard, minute: minutes))
            break
        case 6:
            let mEvent: MatchEventPlayer?
            switch(self.indexSecondTF) {
            case 0:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.ballCapted, minute: minutes)
                break
            case 1:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.ballPushed, minute: minutes)
                break
            case 2:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.airInterceptionSucceed, minute: minutes)
                break
            case 3:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.footInterceptionSucceed, minute: minutes)
                break
            case 4:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.airInterceptionFailed, minute: minutes)
                break
            case 5:
                mEvent = MatchEventPlayer(player: player, matchEvent: MatchEvents.footInterceptionFailed, minute: minutes)
                break
            default:
                mEvent = nil
                break
            }
            
            teamStats.goalEvent.append(mEvent!)
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
