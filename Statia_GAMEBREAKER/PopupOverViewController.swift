//
//  PopupOverViewController.swift
//  Statia_GAMEBREAKER
//
//  Created by Nico on 01/07/2018.
//  Copyright © 2018 Statia. All rights reserved.
//

import UIKit

class PopupOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    @IBAction func startRecord(_ sender: Any) {
//
//        if let path = Bundle.main.path(forResource: "Dispositif de filmage", ofType: "mov") {
//            let video = AVPlayer(url: URL(fileURLWithPath: path))
//            let videoPlayer = AVPlayerViewController()
//            videoPlayer.player = video
//
//            present(videoPlayer, animated: true, completion: {
//                video.play()
//            })
//
//            let X_Position:CGFloat? = 50.0 //use your X position here
//            let Y_Position:CGFloat? = 50.0 //use your Y position here
//
//            let startButton = UIButton(type: UIButtonType.infoLight)
//            startButton.frame = CGRect(x: X_Position!, y: Y_Position!, width: 80, height: 80)
//        }
//    }
//
//    func playLocalVideo() {
//        guard let path = Bundle.main.path(forResource: "Dispositif de filmage", ofType:"m4v") else {
//            debugPrint("video.m4v not found")
//            return
//        }
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//        }
//    }
//    
//    func playNetworkVideo() {
//        let videoURL = NSURL(string: "https://www.youtube.com/embed/AnTn1JoHvUg")
//        let player = AVPlayer(url: videoURL! as URL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
//    }
//    
//    private var customView: UIView!
//    // Show a popup for the selection of the player.
//    func selectPlayer(messageTitle: String, messageAlert: String, messageBoxStyle: UIAlertControllerStyle, completionHandler: @escaping () -> Void)
//    {
//        let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageBoxStyle)
//        
//        let okAction = UIAlertAction(title: "Valider", style: UIAlertActionStyle.default) { _ in
//            completionHandler() // This will only get called after okay is tapped in the alert
//            print("Test")
//        }
//        let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.default) { _ in
//            completionHandler() // This will only get called after okay is tapped in the alert
//        }
//        
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//        
//        
//        //        let customViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
//        //        customView = UIView(frame: customViewFrame)
//        //
//        //        view.addSubview(customView)
//        //
//        //        customView.isHidden = false
//        //
//        //        // any other objects should be tied to this view as superView
//        //        // for example adding this okayButton
//        //
//        //        let okayButtonFrame = CGRect(x: 40, y: 100, width: 50, height: 50)
//        //        let okayButton = UIButton(frame: okayButtonFrame )
//        //
//        //        // here we are adding the button its superView
//        //        customView.addSubview(okayButton)
//        
//        //        okayButton.addTarget(self, action: #selector(self.didPressButtonFromCustomView:), forControlEvents:.TouchUpInside)
//        
//    }
//    func didPressButtonFromCustomView(sender:UIButton) {
//        // do whatever you want
//        // make view disappears again, or remove from its superview
//    }
    
    
    //////////////////////////
    //  VIDEO IN BACKGROUND //
    //////////////////////////
    //    var avPlayer: AVPlayer!
    //    var avPlayerLayer: AVPlayerLayer!
    //    var paused: Bool = false
    //
    //    override func viewDidLoad() {
    //
    //        let theURL = Bundle.main.url(forResource: "Dispositif de filmage", withExtension: "m4v")
    //
    //        avPlayer = AVPlayer(url: theURL!)
    //        avPlayerLayer = AVPlayerLayer(player: avPlayer)
    //        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    //        avPlayer.volume = 0
    //        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
    //
    //        avPlayerLayer.frame = view.layer.bounds
    //        view.backgroundColor = UIColor.clear;
    //        view.layer.insertSublayer(avPlayerLayer, at: 0)
    //
    //        NotificationCenter.default.addObserver(self, selector: Selector(("playerItemDidReachEnd:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.currentItem)
    //    }
    //
    //    func playerItemDidReachEnd(notification: NSNotification) {
    //        let p: AVPlayerItem = notification.object as! AVPlayerItem
    //        p.seek(to: kCMTimeZero)
    //    }
    //
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidDisappear(animated)
    //        avPlayer.play()
    //        paused = false
    //    }
    //
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(animated)
    //        avPlayer.pause()
    //        paused = true
    //    }
}
