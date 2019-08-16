//
//  FishOneViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/15.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

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
    
    let fishView = UIImageView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setupUI()
        fishRun()
    }
}

extension FishOneViewController
{
    private func setupUI()
    {
        backgroundView.frame = self.view.bounds
        backgroundView.image = UIImage(named: "背景图")
        self.view.addSubview(backgroundView)
        
        fishView.image = UIImage(named: "鱼1")
        fishView.frame = CGRect(x: 1.2*K_ScreenW, y: 100, width: 0.108*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        self.view.addSubview(fishView)
          //第一个界面没有更小的鱼
//        barLeftFish.frame = CGRect(x: 0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.078*K_ScreenW, height: 0.63*0.078*K_ScreenW)
//        barLeftFish.image = UIImage(named: "小鱼1")
//        self.view.addSubview(barLeftFish)
        
        progressBar.frame = CGRect(x: 0.0255*K_ScreenW + 0.078*K_ScreenW + 0.018*K_ScreenW, y: 0.05*K_ScreenH, width: 0.253*K_ScreenW, height: 0.065*K_ScreenH)
        progressBar.image = UIImage(named: "进度条")
        self.view.addSubview(progressBar)
        
        barRightFish.frame = CGRect(x: progressBar.frame.origin.x + 0.253*K_ScreenW + 0.018*K_ScreenW, y: 0.03*K_ScreenH, width: 0.078*K_ScreenW, height: 0.63*0.078*K_ScreenW)
        barRightFish.image = UIImage(named: "小鱼2")
        self.view.addSubview(barRightFish)
        
        feedButton.frame = CGRect(x: 0.28*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        feedButton.setImage(UIImage(named: "喂食"), for: .normal)
        self.view.addSubview(feedButton)
        
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
    }
    @objc func fishRun()
    {
        //路线1
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: 1.2*K_ScreenW, y: 0.24*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.2*K_ScreenW, y: 0.3*K_ScreenH))
        animation1.values = [value1, value2]
        
        //路线2
        let animation2 = CAKeyframeAnimation(keyPath: "position")
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 1.2*K_ScreenW, y: 0.24*K_ScreenH))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 0.2*K_ScreenW, y: 0.3*K_ScreenH))
        animation2.values = [value3, value4]
        
        //动画组合
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1,animation2]
        animationGroup.duration = 5.0;
        animationGroup.delegate = self
        animationGroup.fillMode = CAMediaTimingFillMode.forwards;
        animationGroup.isRemovedOnCompletion = false
        fishView.layer.add(animationGroup, forKey:nil)
        
//        animation1.autoreverses = false
//        animation1.duration = 5.0
//        animation1.isRemovedOnCompletion = false
//        animation1.fillMode = CAMediaTimingFillMode.forwards
//        animation1.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
//        animation1.delegate = self
//        fishView.layer.add(animation1, forKey: "route1")
    }
}

extension FishOneViewController
{
    @objc func pressNext(_ button: UIButton)
    {
        let SecondVC = FishTwoViewController()
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
}

extension FishOneViewController: CAAnimationDelegate
{
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
//    {
//            print("翻转")
//            var transform: CGAffineTransform = CGAffineTransform.identity
//            transform = CGAffineTransform.init(scaleX: -1, y: 1)
//            fishView.transform = transform
//    }
}

extension FishOneViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
            navigationController.setNavigationBarHidden(true, animated: true)
    }
}

