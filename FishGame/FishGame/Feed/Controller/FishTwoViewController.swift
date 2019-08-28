//
//  FishTwoViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/16.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class FishTwoViewController: UIViewController
{
    let maskView = UIView()
    let maskBackground = UIImageView()
    let maskFish = UIImageView()
    let maskAllAlpha = UIImageView()
    let maskLock = UIImageView()
    let maskLabel = UILabel()
    
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

extension FishTwoViewController
{
    private func setupUI()
    {
        backgroundView.frame = self.view.bounds
        backgroundView.image = UIImage(named: "背景图")
        self.view.addSubview(backgroundView)
        
        fishView.image = UIImage(named: "鱼2")
        fishView.frame = CGRect(x: 700, y: 100, width: 0.108*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        self.view.addSubview(fishView)
        
        barLeftFish.frame = CGRect(x: 0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.078*K_ScreenW, height: 0.63*0.078*K_ScreenW)
        barLeftFish.image = UIImage(named: "小鱼1")
        self.view.addSubview(barLeftFish)
        
        progressBar.frame = CGRect(x: 0.0255*K_ScreenW + 0.078*K_ScreenW + 0.018*K_ScreenW, y: 0.05*K_ScreenH, width: 0.253*K_ScreenW, height: 0.065*K_ScreenH)
        progressBar.image = UIImage(named: "进度条")
        self.view.addSubview(progressBar)
        
        barRightFish.frame = CGRect(x: progressBar.frame.origin.x + 0.253*K_ScreenW + 0.018*K_ScreenW, y: 0.03*K_ScreenH, width: 0.078*K_ScreenW, height: 0.63*0.078*K_ScreenW)
        barRightFish.image = UIImage(named: "小鱼3")
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
        
        maskView.frame = UIScreen.main.bounds
        maskBackground.image = UIImage(named: "背景图")
        maskBackground.frame = CGRect(x: 0, y: 0, width: maskView.frame.width, height: maskView.frame.height)
        maskView.addSubview(maskBackground)
        maskFish.image = UIImage(named: "鱼2")
        maskFish.frame = CGRect(x: 0.3*K_ScreenW, y: 0.25*K_ScreenH, width: 0.4*K_ScreenW, height: 0.3*K_ScreenH)
        maskFish.contentMode = .scaleAspectFit
        maskView.addSubview(maskFish)
        maskAllAlpha.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        maskAllAlpha.frame = CGRect(x: 0, y: 0, width: maskView.frame.width, height: maskView.frame.height)
        maskView.addSubview(maskAllAlpha)
        maskLock.image = UIImage(named: "未解锁")
        maskLock.frame = CGRect(x: (K_ScreenW - 0.117*K_ScreenW)/2, y: (K_ScreenH - 0.117*K_ScreenW)/2, width: 0.117*K_ScreenW, height: 0.117*K_ScreenW)
        maskView.addSubview(maskLock)
        maskLabel.text = "未解锁"
        maskLabel.textAlignment = .center
        maskLabel.textColor = .white
        maskLabel.font = UIFont(name: "PingFang SC", size: 24)
        maskLabel.frame = CGRect(x: 0.3*K_ScreenW, y: 0.7*K_ScreenH, width: 0.4*K_ScreenW, height: 0.1*K_ScreenH)
        maskView.addSubview(maskLabel)
        
        self.view.addSubview(maskView)
        
        turnrightButton.frame = CGRect(x: K_ScreenW - 0.03*K_ScreenW - 0.033*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        turnrightButton.setImage(UIImage(named: "右切换"), for: .normal)
        turnrightButton.addTarget(self, action: #selector(pressNext(_:)), for: .touchUpInside)
        self.view.addSubview(turnrightButton)
        
        if(UIDevice.current.isX())
        {
            turnleftButton.frame = CGRect(x: 0.055*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        }
        else
        {
            turnleftButton.frame = CGRect(x: 0.03*K_ScreenW, y: 0.437*K_ScreenH, width: 0.033*K_ScreenW, height: 0.128*K_ScreenH)
        }
        turnleftButton.setImage(UIImage(named: "左切换"), for: .normal)
        turnleftButton.addTarget(self, action: #selector(pressPrevious(_:)), for: .touchUpInside)
        self.view.addSubview(turnleftButton)
    }
    @objc func fishRun()
    {
        /*
         提供一组关键帧位置，使得动画view的中心依次落在这些关键点上，形成动画
         */
        let animation = CAKeyframeAnimation(keyPath: "position")
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: 0.78*K_ScreenW, y: 0.24*K_ScreenH))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 0.2*K_ScreenW, y: 0.3*K_ScreenH))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 0.5*K_ScreenW, y: 0.6*K_ScreenH))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 0.4*K_ScreenW, y: 0.5*K_ScreenH))
        let value5: NSValue = NSValue(cgPoint: CGPoint(x: 0.25*K_ScreenW, y: 0.4*K_ScreenH))
        let value6: NSValue = NSValue(cgPoint: CGPoint(x: 0.78*K_ScreenW, y: 0.6*K_ScreenH))
        animation.values = [value1, value2, value3, value4, value5, value6]
        
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        animation.duration = 15.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        animation.delegate = self
        fishView.layer.add(animation, forKey: nil)
    }
}

extension FishTwoViewController
{
    @objc func pressPrevious(_ button: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressNext(_ button: UIButton)
    {
        let ThirdVC = FishTreeViewController()
        self.navigationController?.pushViewController(ThirdVC, animated: true)
    }
}

extension FishTwoViewController: CAAnimationDelegate
{
    
}

extension FishTwoViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}

