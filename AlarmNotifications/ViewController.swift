//
//  ViewController.swift
//  AlarmNotifications
//
//  Created by Rus Razvan on 02/04/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import UIKit
import UserNotifications
import Foundation

class ViewController: UIViewController {


    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet var getStartedButton: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var setNotificationButton: UIButton!
    
    
    //first screen labels
    @IBOutlet weak var firstScreenLabel1: UILabel!
    @IBOutlet weak var firstScreenLabel2: UILabel!
    
    
    //variables  for animation parametres , aplhas
    var initialAlphaForFSL:Double!
    var completeAnimatedAlphaForFSL:Double!
    var animationDuration:Double!
    var delay:Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // asking  for send notification permision
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in if granted {} else {} }
        
        // making everithing unclickeble and opach
        datePicker.isEnabled=false
        datePicker.alpha=0.2
        titleText.isEnabled=false
        titleText.alpha=0.0
        messageText.isEnabled=false
        messageText.alpha=0.0
        setNotificationButton.isEnabled=false
        setNotificationButton.alpha=0.2
        TitleLable.alpha=0.8
        backgroundImageView.alpha=1
        backgroundButton.alpha=0
        getStartedButton.alpha=0.5
        
        // preparing parametres for alphas
        initialAlphaForFSL=0.1
        completeAnimatedAlphaForFSL=0.6
        animationDuration=1
        delay=0.1
        
        // preparing alpha for first screens labels and animation
        firstScreenLabel1.alpha=CGFloat(initialAlphaForFSL)
        firstScreenLabel2.alpha=CGFloat(initialAlphaForFSL)
        
        uiAnimation(view: firstScreenLabel1, animationDuration: animationDuration,delay: delay,alpha: completeAnimatedAlphaForFSL)
        uiAnimation(view: firstScreenLabel2, animationDuration: animationDuration,delay: delay,alpha: completeAnimatedAlphaForFSL)
        
      
    
    }


    
    func uiAnimation(view:UIView,animationDuration:Double,delay:TimeInterval,alpha:Double){
        UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
            view.alpha = CGFloat(alpha)
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
          if alpha==self.completeAnimatedAlphaForFSL {
            self.uiAnimation(view: view, animationDuration: animationDuration, delay: delay, alpha: self.initialAlphaForFSL)
            }else{
            self.uiAnimation(view: view, animationDuration: animationDuration, delay: delay, alpha: self.completeAnimatedAlphaForFSL)
            }
        }
    }
    
    
    
    @IBAction func setNotificationButtonClicked(_ sender: Any) {
        
        // declare format of time we wanna see
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        
        // convert time from timePicker to String type
        let timeString = timeFormatter.string(from: datePicker.date)
        //print("Time: \(timeString)")

        // converting string time to int  for user notification components
        let timeComponents = timeString.components(separatedBy: " ")
        let hoursAndMinutes = timeComponents[0].components(separatedBy: ":")
        var hours=Int(hoursAndMinutes[0])
        let minutes=Int(hoursAndMinutes[1])
        if timeComponents[1]=="PM"{
            hours!+=12
        }
        
        
        
        // creating user notification
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        if titleText.text != "" {
            content.title = titleText.text!
        }else{
            content.title = "New Notification Title"
        }
        if messageText.text != "" {
            content.body = messageText.text!
        }else {
            content.body = "You set a notification for this time with no text!"
        }
        content.categoryIdentifier = "alarm"
        //content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        // creating components for user notification
        var dateComponents = DateComponents()
        dateComponents.hour = hours!
        dateComponents.minute = minutes!
        
        // requesting user notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        
        
        // reformating stufs after setting the user notification
        titleText.text=""
        messageText.text=""
        
        


        //print("notification request sent")
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {

        firstScreenLabel1.isHidden=true
        firstScreenLabel2.isHidden=true


        
        //makign evetrithing enagled
        datePicker.isEnabled=true
        datePicker.alpha=1
        titleText.isEnabled=true
        titleText.alpha=0.7
        messageText.isEnabled=true
        messageText.alpha=0.7
        setNotificationButton.isEnabled=true
        setNotificationButton.alpha=1
        TitleLable.alpha=0.8
        backgroundImageView.alpha=1
        backgroundButton.alpha=0.5
        
        getStartedButton.isHidden=true
    
    }
    
    @IBAction func dismisKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

