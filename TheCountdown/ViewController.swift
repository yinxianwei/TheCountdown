//
//  ViewController.swift
//  TheCountdown
//
//  Created by 尹现伟 on 15/5/26.
//  Copyright (c) 2015年 尹现伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dateString:String!

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.font = UIFont(name: "DBLCDTempBlack", size: 60)

        let date = NSDate(timeIntervalSinceNow: 20)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateString = dateFormatter.stringFromDate(date)
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFireMethod:", userInfo: nil, repeats: true)

    }

    
    func timerFireMethod(timer:NSTimer) {
        
        
        let dc =  self.forTheRestWithDateString(dateString)
        if dc != nil{
            var string = String(format: "%02d:%02d:%02d",dc!.hour,dc!.minute,dc!.second)

            label.text = string
        }else{
            timer.invalidate()
            
            self.view.backgroundColor = UIColor.blackColor()
        }
        
    }
    
    func forTheRestWithDateString(timeString:String) -> NSDateComponents?{
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = formatter.dateFromString(timeString)
        if date != nil {
            var calendar = NSCalendar.currentCalendar()
            
            var today = NSDate()
            
            var unitFalgs = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond
            
            
            var components = calendar.components(unitFalgs, fromDate: date!)
            var fireDate = calendar.dateFromComponents(components)
            
            var dc = calendar.components(unitFalgs, fromDate: today, toDate: fireDate!, options: NSCalendarOptions.allZeros)
            
            if dc.day > 0{
                dc.hour += dc.day*24
            }
            if dc.minute > 60 {
                dc.minute = dc.minute%60
                dc.hour += dc.minute/60
            }
            if dc.second <  0{
                return nil
            }
            return dc
        }
        
        return nil;
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

