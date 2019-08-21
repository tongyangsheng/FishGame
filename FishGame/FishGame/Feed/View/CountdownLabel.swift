//
//  CountdownLabel.swift
//  FishGame
//
//  Created by game98 on 2019/8/21.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class CountdownLabel: UILabel
{
    
    var count: Int = 3
    var timer: Timer? = nil
    
    public func startCount()
    {
        initTimer()
    }
}

extension CountdownLabel
{
    private func initTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    @objc func countDown()
    {
        if count > 0
        {
            self.text = count.description
            print(count.description)
            let animation = CAKeyframeAnimation(keyPath: "transform.scale")
            
            let value1 = NSNumber(value: 3.0)
            let value2 = NSNumber(value: 2.0)
            let value3 = NSNumber(value: 0.7)
            let value4 = NSNumber(value: 1.0)
            
            animation.values = [value1,value2,value3,value4]
            animation.duration = 0.5
            self.layer.add(animation, forKey: "scalsTime")
            count -= 1
        }
        else
        {
            timer?.invalidate()
            self.text = "GO!"
            let animation = CAKeyframeAnimation(keyPath: "transform.scale")
            
            let value1 = NSNumber(value: 3.0)
            let value2 = NSNumber(value: 2.0)
            let value3 = NSNumber(value: 0.7)
            let value4 = NSNumber(value: 1.0)
            
            animation.values = [value1,value2,value3,value4]
            animation.duration = 0.5
            self.layer.add(animation, forKey: "scalsTime")
        }
    }
}


