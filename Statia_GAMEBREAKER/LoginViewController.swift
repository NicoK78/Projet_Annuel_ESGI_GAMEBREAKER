//
//  LoginViewController.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 01/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var textfieldUsername: UITextField!
    @IBOutlet var textfieldPassword: UITextField!
    @IBOutlet var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.backgroundColor = UIColor.gray.cgColor
        button.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.view.addBackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connection(_ sender: Any) {
        print("IN CONNECT FUNCTION")
        if (textfieldUsername.text != "" && textfieldPassword.text != ""){
            let username = textfieldUsername.text
            let password = textfieldPassword.text
            
            let parameter: Parameters = [
                "username":username ?? "",
                "password":password ?? ""
            ]
            
            Alamoquest.login(parameter: parameter, completionHandler: { (analyst) in
                print("JSON : \(analyst.toJSON())")
                if (analyst.id == -1){
                    let alert = UIAlertController(title: "Attention", message: "Identifiant ou mot de passe incorect", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }else{
//                    if let analyst =
                    print("=========> ANALYSTE : \(analyst.id)")
                    UserDefaults.standard.set(analyst.id, forKey: "idAnalyst")
                    let homeView = SelectMatchViewController(nibName: "SelectMatchViewController", bundle: nil)
                    self.navigationController?.pushViewController(homeView, animated: true)
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background_blue.jpg")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
}
