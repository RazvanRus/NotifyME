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
        
        
      
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        for i in 1...6 {
            self.view.viewWithTag(i)?.isHidden=true
        }

        
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

