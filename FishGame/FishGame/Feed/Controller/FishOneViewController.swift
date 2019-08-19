//
//  FishOneViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/15.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import Lottie

class FishOneViewController: UIViewController
{
    
    let backgroundView = UIImageView()
    let feedButton = UIButton()
    let earnButton = UIButton()
    let offButton = UIButton()
    let screenshotButton = UIButton()
    let turnleftButton = UIButton()
    let turnrightButton = UIButton()
    
    let progressBar = UIImageView()
    let barLeftFish = UIImageView()
    let barRightFish = UIImageView()
    
    let fishView = UIView()
    let fishBubble = AnimationView()
    let fishImage = UIImageView()
    
    let BaitStr = UILabel()

    let Bubble1 = BubbleView(frame: CGRect(x: 0.45*K_ScreenW, y: 0.1*K_ScreenH, width: 0.135*K_ScreenW, height: 0.72*0.135*K_ScreenW), idiom: "学富五车")
    let Bubble2 = BubbleView(frame: CGRect(x: 0.1*K_ScreenW, y: 0.45*K_ScreenH, width: 0.135*K_ScreenW, height: 0.72*0.135*K_ScreenW), idiom: "车水马龙")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setupUI()
        fishRunRoute1()
    }
}

extension FishOneViewController
{
    private func setupUI()
    {
        backgroundView.frame = self.view.bounds
        backgroundView.image = UIImage(named: "背景图")
        self.view.addSubview(backgroundView)
        
        fishView.frame = CGRect(x: 1.2*K_ScreenW, y: 100, width: 0.18*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        let animation = Animation.named("fishJson")
        fishBubble.animation = animation
        fishBubble.contentMode = .scaleAspectFit
        fishBubble.play()
        fishBubble.loopMode = .loop
        fishBubble.isUserInteractionEnabled = true
        fishBubble.tag = 1000
        fishBubble.frame = CGRect(x: 0, y: -10, width: 0.092*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        
        fishImage.image = UIImage(named: "鱼1")
        fishImage.frame = CGRect(x: 0.03*K_ScreenW, y: 0, width: 0.108*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        
        
        fishView.addSubview(fishBubble)
        
        fishView.addSubview(fishImage)

        self.view.addSubview(fishView)
        //        第一个界面没有更小的鱼
        //        barLeftFish.frame = CGRect(x: 0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.078*K_ScreenW, height: 0.63*0.078*K_ScreenW)
        //        barLeftFish.image = UIImage(named: "小鱼1")
        //        self.view.addSubview(barLeftFish)
        
        progressBar.frame = CGRect(x: 0.0255*K_ScreenW + 0.078*K_ScreenW + 0.018*K_ScreenW, y: 0.05*K_ScreenH, width: 0.253*K_ScreenW, height: 0.065*K_ScreenH)
        progressBar.image = UIImage(named: "进度条")
        self.view.addSubview(progressBar)
        
        barRightFish.frame = CGRect(x: progressBar.frame.origin.x + 0.253*K_ScreenW + 0.018*K_ScreenW, y: 0.035*K_ScreenH, width: 0.06*K_ScreenW, height: 0.63*0.06*K_ScreenW)
        barRightFish.image = UIImage(named: "小鱼2")
        self.view.addSubview(barRightFish)
        
        feedButton.frame = CGRect(x: 0.28*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        feedButton.setImage(UIImage(named: "喂食"), for: .normal)
        feedButton.addTarget(self, action: #selector(pressFeed(_:)), for: .touchUpInside)
        self.view.addSubview(feedButton)
        
        print(feedButton.frame.width)
        
        BaitStr.frame = CGRect(x: feedButton.frame.origin.x + 0.6*feedButton.frame.width, y: feedButton.frame.origin.y+0.32*feedButton.frame.height, width: 0.14*feedButton.frame.width, height: 0.6*0.14*feedButton.frame.width)
        BaitStr.textColor = .white
        BaitStr.textAlignment = .center
        BaitStr.text = K_Bait.description
        self.view.addSubview(BaitStr)
        
        earnButton.frame = CGRect(x: K_ScreenW - 0.28*K_ScreenW - 0.2*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        earnButton.setImage(UIImage(named: "赚取鱼食"), for: .normal)
        self.view.addSubview(earnButton)
        
        offButton.frame = CGRect(x: K_ScreenW - 0.057*K_ScreenW - 0.027*K_ScreenW , y: 0.04*K_ScreenH, width: 0.057*K_ScreenW, height: 0.057*K_ScreenW)
        offButton.setImage(UIImage(named: "关闭"), for: .normal)
        self.view.addSubview(offButton)
        
        screenshotButton.frame = CGRect(x: offButton.frame.origin.x - 0.005*K_ScreenW - 0.057*K_ScreenW, y: 0.04*K_ScreenH, width: 0.057*K_ScreenW, height: 0.057*K_ScreenW)
        screenshotButton.setImage(UIImage(named: "拍照"), for: .normal)
        self.view.addSubview(screenshotButton)
        
        turnrightButton.frame = CGRect(x: K_ScreenW - 0.03*K_ScreenW - 0.033*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        turnrightButton.setImage(UIImage(named: "右切换"), for: .normal)
        turnrightButton.addTarget(self, action: #selector(pressNext(_:)), for: .touchUpInside)
        self.view.addSubview(turnrightButton)
        //第一个界面不能左滑
        //        if(UIDevice.current.isX())
        //        {
        //            turnleftButton.frame = CGRect(x: 0.055*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        //        }
        //        else
        //        {
        //            turnleftButton.frame = CGRect(x: 0.03*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        //        }
        //        turnleftButton.setImage(UIImage(named: "左切换"), for: .normal)
        //        self.view.addSubview(turnleftButton)
        setupBubble()
    }
    private func setupBubble()
    {
        Bubble1.alpha = 0.0
        self.view.addSubview(Bubble1)
        Bubble2.alpha = 0.0
        self.view.addSubview(Bubble2)
    }
}

extension FishOneViewController
{
    @objc func fishRunRoute1()
    {
        //路线1
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: 1.21*K_ScreenW, y: 0.24*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.9*K_ScreenW, y: 0.6*K_ScreenH))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 0.7*K_ScreenW, y: 0.35*K_ScreenH))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 0.3*K_ScreenW, y: 0.65*K_ScreenH))
        let value5: NSValue = NSValue(cgPoint: CGPoint(x: -0.1*K_ScreenW, y: 0.3*K_ScreenH))
        animation1.values = [value1, value2, value3, value4, value5]
        
        animation1.autoreverses = false
        animation1.duration = 10.0
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = CAMediaTimingFillMode.forwards
        animation1.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        animation1.delegate = self
        fishView.layer.add(animation1, forKey: "route1")
        UIView.animate(withDuration: 1.0, delay: 5, options: .curveEaseIn, animations: {
            self.Bubble1.alpha = 1.0
        }, completion: {(Bool) in UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.Bubble1.alpha = 0.0
        }, completion: nil)})
    }
    @objc func fishRunRoute2()
    {
        //路线2
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: -0.1*K_ScreenW, y: 0.3*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.14*K_ScreenW, y: 0.75*K_ScreenH))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 0.4*K_ScreenW, y: 0.3*K_ScreenH))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 0.7*K_ScreenW, y: 0.6*K_ScreenH))
        let value5: NSValue = NSValue(cgPoint: CGPoint(x: 1.1*K_ScreenW, y: 0.5*K_ScreenH))
        animation1.values = [value1, value2, value3, value4, value5]
        
        animation1.autoreverses = false
        animation1.duration = 12.0
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = CAMediaTimingFillMode.forwards
        animation1.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        animation1.delegate = self
        fishView.layer.add(animation1, forKey: "route2")
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseIn, animations: {
            self.Bubble2.alpha = 1.0
        }, completion: {(Bool) in UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.Bubble2.alpha = 0.0
        }, completion: nil)})
    }
    @objc func fishRunRoute3()
    {
        //路线3
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: 1.1*K_ScreenW, y: 0.5*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.5*K_ScreenW, y: 0.25*K_ScreenH))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: -0.1*K_ScreenW, y: 0.3*K_ScreenH))
        animation1.values = [value1, value2, value3]
        
        animation1.autoreverses = false
        animation1.duration = 8.0
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = CAMediaTimingFillMode.forwards
        animation1.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        animation1.delegate = self
        fishView.layer.add(animation1, forKey: "route3")
    }
    @objc func fishRunRoute4()
    {
        //路线4
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: -0.1*K_ScreenW, y: 0.3*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.2*K_ScreenW, y: 0.25*K_ScreenH))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 0.3*K_ScreenW, y: 0.6*K_ScreenH))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 0.6*K_ScreenW, y: 0.5*K_ScreenH))
        let value5: NSValue = NSValue(cgPoint: CGPoint(x: 1.1*K_ScreenW, y: 0.24*K_ScreenH))
        
        animation1.values = [value1, value2, value3, value4, value5]
        
        animation1.autoreverses = false
        animation1.duration = 11.0
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = CAMediaTimingFillMode.forwards
        animation1.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        animation1.delegate = self
        fishView.layer.add(animation1, forKey: "route4")
    }
}

extension FishOneViewController
{
    @objc func pressNext(_ button: UIButton)
    {
        let SecondVC = FishTwoViewController()
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    
    @objc func pressFeed(_ button: UIButton)
    {
        let WarningView = LowBaitView()
        WarningView.show()
    }
}

extension FishOneViewController: CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        if self.fishView.layer.animationKeys()! == ["route1"]
        {
            var transform: CGAffineTransform = CGAffineTransform.identity
            transform = CGAffineTransform.init(scaleX: -1, y: 1)
            fishView.transform = transform
            fishView.layer.removeAllAnimations()
            fishRunRoute2()
        }
        else
        {
            if self.fishView.layer.animationKeys()! == ["route2"]
            {
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute3()
            }
            else
            {
                if self.fishView.layer.animationKeys()! == ["route3"]
                {
                    var transform: CGAffineTransform = CGAffineTransform.identity
                    transform = CGAffineTransform.init(scaleX: -1, y: 1)
                    fishView.transform = transform
                    fishView.layer.removeAllAnimations()
                    fishRunRoute4()
                }
                else
                {
                    var transform: CGAffineTransform = CGAffineTransform.identity
                    transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    fishView.transform = transform
                    fishView.layer.removeAllAnimations()
                    fishRunRoute1()
                }
            }
        }
    }
}

extension FishOneViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}


