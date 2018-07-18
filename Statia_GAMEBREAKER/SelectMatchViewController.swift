//
//  SelectMatchViewController.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 01/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import Foundation

class SelectMatchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var date: UILabel!
    @IBOutlet var competition: UILabel!
    @IBOutlet var grass: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    
    @IBOutlet var startHour: UILabel!
    @IBOutlet var day: UILabel!
    @IBOutlet var condition: UILabel!
    @IBOutlet var precipitation: UILabel!
    @IBOutlet var windStrength: UILabel!
    
    @IBOutlet var svHome: UIStackView!
    @IBOutlet var svAway: UIStackView!
    
    @IBOutlet var svInfos: UIStackView!
    
    var matches: Array<Match> = []
    var matchesStr: Array<String> = []
    
    
    @IBOutlet var pickerView: UIPickerView!
    var pickerIndex = 0
    
    @IBAction func startAnalyze(_ sender: Any) {
        let homeView = GameBreakerViewController(nibName: "GameBreakerViewController", bundle: Bundle.main)
        
        if(pickerIndex >= 1) {
            
            homeView.homeTeam = matches[pickerIndex-1].home
            homeView.awayTeam = matches[pickerIndex-1].away
            
            homeView.homeStats = StatsTeam()
            homeView.homeStats?.team = matches[pickerIndex-1].home
            homeView.homeStats?.idTeam = homeView.homeStats?.team?.id
            homeView.awayStats = StatsTeam()
            homeView.awayStats?.team = matches[pickerIndex-1].away
            homeView.awayStats?.idTeam = homeView.awayStats?.team?.id
            
            homeView.homeStats?.idMatch = matches[pickerIndex-1].id
            homeView.awayStats?.idMatch = matches[pickerIndex-1].id
            self.navigationController?.pushViewController(homeView, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setMatches()
        
        pickerView.delegate = self
        pickerView.isHidden = false
        
        svInfos.layer.cornerRadius = 15.0
        svInfos.layer.borderWidth = 5.0
        svInfos.layer.borderColor = UIColor.cyan.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (matches.count) + 1
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(row == 0) {
            return "SELECTIONNEZ UN MATCH"
        } else {
            return "\(matches[row-1].home.name!) - \(matches[row-1].away.name!)"
        }
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerIndex = row
        
        date.text = row == 0 ? "" : "31/08/2018"
        competition.text = row == 0 ? "" : "Championnat"
        grass.text = row == 0 ? "" : "Synthétique"
        temperature.text = row == 0 ? "" : "20°C"
        humidity.text = row == 0 ? "" : "50%"
        
        startHour.text = row == 0 ? "" : "21H00"
        day.text = row == 0 ? "" : "6"
        condition.text = row == 0 ? "" : "Temps clair"
        precipitation.text = row == 0 ? "" : "15%"
        windStrength.text = row == 0 ? "" : "10 km/h"
        
        svHome.removeAllArrangedSubviews()
        svAway.removeAllArrangedSubviews()
        if(row != 0) {
            Alamoquest.getPlayerByTeam(id: (matches[row-1].home.id)!) { (players) in
                for player in players {
                    self.svHome.addArrangedSubview(self.addLabelInSV(player: player, width: self.svHome.frame.size.width))
                }
            }
            Alamoquest.getPlayerByTeam(id: (matches[row-1].away.id)!) { (players) in
                for player in players {
                    self.svAway.addArrangedSubview(self.addLabelInSV(player: player, width: self.svAway.frame.size.width))
                }
            }
        }
    }
    
    func addLabelInSV(player: Player, width: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 22))
        
        label.textAlignment = NSTextAlignment.center
        label.text = "N°X \(player.name!) \(player.firstname!)"
        label.font = label.font.withSize(20)
        
        return label
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        Alamoquest.getMatchToAnalyze { (matchs) in
            print(matchs.toJSON())
            for match in matchs {
                self.matches.append(match)
                self.matchesStr.append(match.home.name + " - " + match.away.name)
            }
            self.pickerView.reloadAllComponents()
        }
    }

}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
