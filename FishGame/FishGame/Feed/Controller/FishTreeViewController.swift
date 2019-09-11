//
//  FishTreeViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/28.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import Lottie
import STKitSwift
import AudioToolbox
import Toast_Swift
import AVFoundation

class FishTreeViewController: UIViewController
{
    let maskView = UIView()
    let maskBackground = UIImageView()
    let maskFish = UIImageView()
    let maskAllAlpha = UIImageView()
    let maskLock = UIImageView()
    let maskLabel = UILabel()
    
    let turnleftButton = UIButton()
    let turnrightButton = UIButton()
    
    let backgroundView = UIImageView()
    let feedButton = UIButton()
    let earnButton = UIButton()
    let offButton = UIButton()
    let screenshotButton = UIButton()
    
    let progressBar = UIImageView()
    let barLeftFish = UIImageView()
    let barRightFish = UIImageView()
    
    let fishView = UIImageView()
    let fishBubble = AnimationView()
    let fishImage = UIImageView()
    
    let BaitStr = UILabel()
    
    let progressLabel = UILabel()
    let progressBackImage = UIImageView()
    
    let BaitAnimationView = AnimationView()
    let backgroudFish = AnimationView()
    
    let userdefault = UserDefaults.standard
    
    var nowCenterPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    var fishProgressNow: Double = 0
    
    private lazy var progressView: STProgressView = {
        let progressView = STProgressView()
        progressView.backgroundColor = UIColor.init(r: 204, g: 204, b: 204)
        progressView.startColor = UIColor.init(r: 255, g: 183, b: 39)
        
        progressView.endColor = UIColor.init(r: 255, g: 183, b: 39)
        
        progressView.cornerRadius = 11
        progressView.progress = 0
        self.view.addSubview(progressView)
        return progressView
    }()
    
    let Bubble1 = BubbleView(frame: CGRect(x: 0.45*K_ScreenW, y: 0.1*K_ScreenH, width: 0.135*K_ScreenW, height: 0.72*0.135*K_ScreenW), idiom: "栉风沐雨")
    let Bubble2 = BubbleView(frame: CGRect(x: 0.1*K_ScreenW, y: 0.45*K_ScreenH, width: 0.135*K_ScreenW, height: 0.72*0.135*K_ScreenW), idiom: "在所难免")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        BaitStr.text = K_Bait.description
        
        fishBubble.play()
        fishBubble.loopMode = .loop
        BaitAnimationView.play()
        BaitAnimationView.loopMode = .loop
        backgroudFish.play()
        backgroudFish.loopMode = .loop
        var transform: CGAffineTransform = CGAffineTransform.identity
        transform = CGAffineTransform.init(scaleX: 1, y: 1)
        fishView.transform = transform
        fishRunRoute1()
        
        if K_GameProgress > 3
        {
            progressView.progress = 1
            fishProgressNow = 100
            let progressInt = Int(fishProgressNow)
            progressLabel.text = "\(progressInt)/100"
        }
        else
        {
            let progressInt = Int(fishProgressNow)
            progressLabel.text = "\(progressInt)/100"
            let progressNow = fishProgressNow / 100.0
            progressView.progress = CGFloat(progressNow)
        }
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        fishView.layer.removeAllAnimations()
    }
}

extension FishTreeViewController
{
    private func setupUI()
    {
        backgroundView.frame = self.view.bounds
        backgroundView.image = UIImage(named: "背景图")
        self.view.addSubview(backgroundView)
        
        fishView.frame = CGRect(x: 1.2*K_ScreenW, y: 100, width: 0.18*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        //指定加载的JSON文件
        let animation = Animation.named("fishJson")
        //将动画添加到AnimationView
        fishBubble.animation = animation
        //填充模式（拉伸模式）
        fishBubble.contentMode = .scaleAspectFit
        //开启动画
        fishBubble.play()
        //动画循环播放
        fishBubble.loopMode = .loop
        //动画位置
        fishBubble.frame = CGRect(x: 0, y: -10, width: 0.092*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        let animation1 = Animation.named("beijing_x")
        let imageProvider = BundleImageProvider(bundle: Bundle.main, searchPath: "img_4")
        backgroudFish.animation = animation1
        backgroudFish.imageProvider = imageProvider
        backgroudFish.contentMode = .scaleAspectFit
        backgroudFish.play()
        backgroudFish.loopMode = .loop
        backgroudFish.isUserInteractionEnabled = true
        backgroudFish.tag = 1002
        backgroudFish.frame = UIScreen.main.bounds
        self.view.addSubview(backgroudFish)
        
        progressBackImage.image = UIImage(named: "进度条")
        progressBackImage.frame = CGRect(x: 0.11*K_ScreenW, y: 0.035*K_ScreenH, width: 0.29*K_ScreenW, height: 0.09*K_ScreenH)
        self.view.addSubview(progressBackImage)
        
        progressView.snp.makeConstraints { (maker) in
            maker.left.equalTo(0.117*K_ScreenW)
            maker.width.equalTo(0.277*K_ScreenW)
            maker.top.equalTo(0.053*K_ScreenH)
            maker.height.equalTo(0.053*K_ScreenH)
        }
        
        progressLabel.frame = CGRect(x: 0.12*K_ScreenW + 0.5*0.27*K_ScreenW - 50, y: 0.053*K_ScreenH, width: 100, height: 0.053*K_ScreenH)
        progressLabel.textAlignment = .center
        progressLabel.textColor = .white
        progressLabel.font = UIFont(name: "PingFang SC", size: 12)
        let progressInt = Int(fishProgressNow)
        progressLabel.text = "\(progressInt)/100"
        self.view.addSubview(progressLabel)
        
        fishImage.image = UIImage(named: "鱼3")
        fishImage.frame = CGRect(x: 0.03*K_ScreenW, y: 0, width: 0.108*K_ScreenW, height: 0.653*0.108*K_ScreenW)
        
        fishView.addSubview(fishBubble)
        
        fishView.addSubview(fishImage)
        
        self.view.addSubview(fishView)
        
        barLeftFish.frame = CGRect(x: 0.03*K_ScreenW, y: 0.03*K_ScreenH, width: 0.06*K_ScreenW, height: 0.775*0.06*K_ScreenW)
        barLeftFish.image = UIImage(named: "小鱼2")
        self.view.addSubview(barLeftFish)
        
        barRightFish.frame = CGRect(x: 0.11*K_ScreenW + 0.29*K_ScreenW + 0.018*K_ScreenW, y: 0.032*K_ScreenH, width: 0.06*K_ScreenW, height: 0.8*0.06*K_ScreenW)
        barRightFish.image = UIImage(named: "小鱼4")
        self.view.addSubview(barRightFish)
        
        feedButton.frame = CGRect(x: 0.28*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        feedButton.setImage(UIImage(named: "喂食"), for: .normal)
        feedButton.addTarget(self, action: #selector(pressFeed(_:)), for: .touchUpInside)
        
        BaitStr.frame = CGRect(x: feedButton.frame.origin.x + 0.58*feedButton.frame.width, y: feedButton.frame.origin.y+0.32*feedButton.frame.height, width: 0.2*feedButton.frame.width, height: 0.6*0.14*feedButton.frame.width)
        BaitStr.textColor = .white
        BaitStr.textAlignment = .center
        BaitStr.font = UIFont.systemFont(ofSize: 16)
        BaitStr.text = K_Bait.description
        
        earnButton.frame = CGRect(x: K_ScreenW - 0.28*K_ScreenW - 0.2*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        earnButton.setImage(UIImage(named: "赚取鱼食"), for: .normal)
        earnButton.addTarget(self, action: #selector(pressEarn(_:)), for: .touchUpInside)
        
        if K_GameProgress == 3
        {
            self.view.addSubview(feedButton)
            self.view.addSubview(BaitStr)
            self.view.addSubview(earnButton)
        }
        
        offButton.frame = CGRect(x: K_ScreenW - 0.057*K_ScreenW - 0.027*K_ScreenW , y: 0.04*K_ScreenH, width: 0.057*K_ScreenW, height: 0.057*K_ScreenW)
        offButton.addTarget(self, action: #selector(quitApp(_:)), for: .touchUpInside)
        offButton.setImage(UIImage(named: "关闭"), for: .normal)
        self.view.addSubview(offButton)
        
        screenshotButton.frame = CGRect(x: offButton.frame.origin.x - 0.005*K_ScreenW - 0.057*K_ScreenW, y: 0.04*K_ScreenH, width: 0.057*K_ScreenW, height: 0.057*K_ScreenW)
        screenshotButton.setImage(UIImage(named: "拍照"), for: .normal)
        screenshotButton.addTarget(self, action: #selector(pressScreenshot(_:)), for: .touchUpInside)
        self.view.addSubview(screenshotButton)
        
        setupBubble()
        
        if K_GameProgress < 3
        {
            setMask()
        }
        else
        {
            
        }
        
        
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
    @objc func setMask()
    {
        maskView.frame = UIScreen.main.bounds
        maskBackground.image = UIImage(named: "背景图")
        maskBackground.frame = CGRect(x: 0, y: 0, width: maskView.frame.width, height: maskView.frame.height)
        maskView.addSubview(maskBackground)
        maskFish.image = UIImage(named: "鱼3")
        maskFish.frame = CGRect(x: 0.3*K_ScreenW, y: 0.25*K_ScreenH, width: 0.4*K_ScreenW, height: 0.3*K_ScreenH)
        maskFish.contentMode = .center
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
    }
    
    private func setupBubble()
    {
        Bubble1.alpha = 0.0
        self.view.addSubview(Bubble1)
        Bubble2.alpha = 0.0
        self.view.addSubview(Bubble2)
    }
}

extension FishTreeViewController
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

@objc func fishGetFoodRouteRightToLeft()
{
    let animation = CAKeyframeAnimation(keyPath: "position")
    
    if nowCenterPoint.x < 0.55*K_ScreenW
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        transform = CGAffineTransform.init(scaleX: -1, y: 1)
        fishView.transform = transform
        let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
        let endValue: NSValue = NSValue(cgPoint: CGPoint(x: 0.43*K_ScreenW, y: 0.4*K_ScreenH))
        
        animation.values = [startValue,endValue]
        
        animation.autoreverses = false
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.delegate = self
        fishView.layer.add(animation, forKey: "route5")
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute:
            {
                self.BaitAnimationView.removeFromSuperview()
                self.nowCenterPoint = self.fishView.layer.position
                self.fishView.layer.position = self.fishView.layer.presentation()!.position
                self.finishEatToRight()
        })
    }
    else
    {
        let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
        let endValue: NSValue = NSValue(cgPoint: CGPoint(x: 0.55*K_ScreenW, y: 0.4*K_ScreenH))
        
        animation.values = [startValue,endValue]
        
        animation.autoreverses = false
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.delegate = self
        fishView.layer.add(animation, forKey: "route5")
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute:
            {
                self.BaitAnimationView.removeFromSuperview()
                self.nowCenterPoint = self.fishView.layer.position
                self.fishView.layer.position = self.fishView.layer.presentation()!.position
                self.finishEatToLeft()
        })
    }
}

@objc func fishGetFoodRouteLeftToRight()
{
    let animation = CAKeyframeAnimation(keyPath: "position")
    if nowCenterPoint.x > 0.55*K_ScreenW
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        transform = CGAffineTransform.init(scaleX: 1, y: 1)
        fishView.transform = transform
        let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
        let endValue: NSValue = NSValue(cgPoint: CGPoint(x: 0.55*K_ScreenW, y: 0.4*K_ScreenH))
        animation.values = [startValue,endValue]
        
        animation.autoreverses = false
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.delegate = self
        fishView.layer.add(animation, forKey: "route6")
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute:
            {
                self.BaitAnimationView.removeFromSuperview()
                self.nowCenterPoint = self.fishView.layer.position
                self.fishView.layer.position = self.fishView.layer.presentation()!.position
                self.finishEatToLeft()
        })
    }
    else
    {
        let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
        let endValue: NSValue = NSValue(cgPoint: CGPoint(x: 0.43*K_ScreenW, y: 0.4*K_ScreenH))
        
        animation.values = [startValue,endValue]
        
        animation.autoreverses = false
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.delegate = self
        fishView.layer.add(animation, forKey: "route6")
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute:
            {
                self.BaitAnimationView.removeFromSuperview()
                self.nowCenterPoint = self.fishView.layer.position
                self.fishView.layer.position = self.fishView.layer.presentation()!.position
                self.finishEatToRight()
        })
    }
}

@objc func finishEatToLeft()
{
    let animation = CAKeyframeAnimation(keyPath: "position")
    let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
    let endValue: NSValue = NSValue(cgPoint: CGPoint(x: -0.1*K_ScreenW, y: 0.8*K_ScreenH))
    
    animation.values = [startValue,endValue]
    
    animation.autoreverses = false
    animation.duration = 3
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.delegate = self
    fishView.layer.add(animation, forKey: "route7")
}
@objc func finishEatToRight()
{
    let animation = CAKeyframeAnimation(keyPath: "position")
    let startValue: NSValue = NSValue(cgPoint: nowCenterPoint)
    let endValue: NSValue = NSValue(cgPoint: CGPoint(x: 1.1*K_ScreenW, y: 0.8*K_ScreenH))
    
    animation.values = [startValue,endValue]
    
    animation.autoreverses = false
    animation.duration = 3
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.delegate = self
    fishView.layer.add(animation, forKey: "route8")
}

@objc func pushBait()
{
    let animation = Animation.named("weishi")
    BaitAnimationView.animation = animation
    BaitAnimationView.contentMode = .scaleAspectFit
    BaitAnimationView.play()
    BaitAnimationView.loopMode = .loop
    BaitAnimationView.isUserInteractionEnabled = true
    BaitAnimationView.tag = 1000
    BaitAnimationView.frame = CGRect(x: 0.44*K_ScreenW, y: 0, width: 0.1*K_ScreenW, height: 0.47*K_ScreenH)
    self.view.addSubview(BaitAnimationView)
}
}

extension FishTreeViewController
{
    @objc func pressPrevious(_ button: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func quitApp(_ button: UIButton)
    {
        exit(0)
    }
    
    @objc func pressNext(_ button: UIButton)
    {
        let NextVC = FishFourViewController()
        self.navigationController?.pushViewController(NextVC, animated: true)
    }
    
    @objc func pressFeed(_ button: UIButton)
    {
        NotificationCenter.default.addObserver(self, selector: #selector(pressEarn(_:)), name: NSNotification.Name(rawValue:"toEarn\(K_EarnTime)"), object: nil)
        if fishView.layer.animationKeys() == ["route1"] || fishView.layer.animationKeys() == ["route2"] || fishView.layer.animationKeys() == ["route3"] || fishView.layer.animationKeys() == ["route4"]
        {
            if K_Bait < 10
            {
                let WarningView = LowBaitView()
                WarningView.show()
            }
            else
            {
                guard let animationName = self.fishView.layer.animationKeys() else {  print("当前无动画"); return }
                if animationName == ["route1"]||animationName == ["route3"]
                {
                    fishView.layer.removeAllAnimations()
                    fishView.layer.position = fishView.layer.presentation()!.position
                    
                    Bubble1.alpha = 0
                    Bubble2.alpha = 0
                    Bubble1.layer.removeAllAnimations()
                    Bubble2.layer.removeAllAnimations()
                    
                    nowCenterPoint = fishView.layer.position
                    
                    pushBait()
                    fishGetFoodRouteRightToLeft()
                    
                }
                else
                {
                    fishView.layer.removeAllAnimations()
                    fishView.layer.position = fishView.layer.presentation()!.position
                    
                    Bubble1.alpha = 0
                    Bubble2.alpha = 0
                    Bubble1.layer.removeAllAnimations()
                    Bubble2.layer.removeAllAnimations()
                    
                    nowCenterPoint = fishView.layer.position
                    
                    pushBait()
                    fishGetFoodRouteLeftToRight()
                    
                }
                
                K_Bait = K_Bait - 10
                fishProgressNow = fishProgressNow + 10
                ObserveBait()
                ObserveProgress()
                var progressNow = fishProgressNow / 100.0
                if progressNow >= 1
                {
                    progressNow = 1
                    K_GameProgress = 4
                    print("进入第四关！")
                    feedButton.removeFromSuperview()
                    BaitStr.removeFromSuperview()
                    earnButton.removeFromSuperview()
                }
                progressView.progress = CGFloat(progressNow)
            }
        }
        else
        {
            if K_Bait < 10
            {
                let WarningView = LowBaitView()
                WarningView.show()
                K_Bait = 0
            }
            else
            {
                let min1: UInt32 = 1
                let max1: UInt32 = 5
                let randomFish = arc4random_uniform(max1 - min1) + min1
                var fishMessage: String
                switch randomFish
                {
                case 1:
                    fishMessage = "主人，我吃饱了，让我先游一会儿吧！"
                    break
                case 2:
                    fishMessage = "饭后运动，有益身心"
                    break
                case 3:
                    fishMessage = "我还是先消化会儿吧，主人"
                    break
                case 4:
                    fishMessage = "刚刚饱餐一顿，还是休息会儿吧"
                    break
                default:
                    fishMessage = "刚刚饱餐一顿，还是休息会儿吧"
                    break
                }
                self.view.makeToast(fishMessage, duration: 3.0, position: .bottom, title: "鱼儿：", image: UIImage(named: "鱼3"), style: ToastStyle(), completion: nil)
            }
        }
    }
    
    @objc func pressScreenshot(_ button: UIButton)
    {
        var soundID: SystemSoundID = 0
        let path = Bundle.main.path(forResource: "photoShutter", ofType: "caf")
        let baseURL = NSURL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        
        let flashView = UIView()
        flashView.frame = CGRect(x: 0, y: 0, width: K_ScreenW, height: K_ScreenH)
        flashView.backgroundColor = .white
        self.view.addSubview(flashView)
        flashView.alpha = 1
        UIView.beginAnimations("flash screen", context: nil)
        UIView.setAnimationDuration(0.7)
        UIView.setAnimationCurve(.easeInOut)
        flashView.alpha = 0
        UIView.commitAnimations()
        let WarningView = ScreenShotView(frame: UIScreen.main.bounds, fishTypeImageStr: "鱼3")
        WarningView.show()
    }
    
    @objc func pressEarn(_ button: UIButton)
    {
        let countdownView = UIView()
        countdownView.frame = UIScreen.main.bounds
        countdownView.backgroundColor = UIColor(r: 236, g: 249, b: 255)
        let countdownLabel = CountdownLabel()
        countdownLabel.frame = CGRect(x: (K_ScreenW-200)/2, y: (K_ScreenH-20)/2, width: 200, height: 50)
        countdownLabel.textAlignment = .center;
        countdownLabel.textColor = UIColor(r: 0, g: 189, b: 255);
        if K_ScreenW > 375
        {
            countdownLabel.font =  UIFont(name: "PingFang SC", size: 35);
        }
        else
        {
            countdownLabel.font =  UIFont(name: "PingFang SC", size: 22);
        }
        countdownLabel.startCount()
        countdownView.addSubview(countdownLabel)
        self.view.addSubview(countdownView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            countdownView.removeFromSuperview()
            let GameVC = MainGameViewController()
            self.fishView.layer.removeAllAnimations()
            self.present(GameVC, animated: true, completion: nil)
        }
    }
    
    private func ObserveBait()
    {
        BaitStr.text = K_Bait.description
    }
    private func ObserveProgress()
    {
        let progressInt = Int(fishProgressNow)
        progressLabel.text = "\(progressInt)/100"
    }
}

extension FishTreeViewController: CAAnimationDelegate
{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        fishView.layer.frame = fishView.layer.presentation()!.frame
        guard let animationName = self.fishView.layer.animationKeys() else {  print("当前无动画"); return }
        switch animationName {
        case ["route1"]:
            do {
                print("调用1")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: -1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute2()
                break
            }
        case ["route2"]:
            do {
                print("调用2")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute3()
                break
            }
        case ["route3"]:
            do {
                print("调用3")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: -1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute4()
                break
            }
        case ["route4"]:
            do {
                print("调用4")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute1()
                break
            }
        case ["route5"]:
            print("调用5")
            //            fishView.layer.position = fishView.layer.presentation()!.position
            break
        case ["route6"]:
            print("调用6")
            //            fishView.layer.position = fishView.layer.presentation()!.position
            break
        case ["route7","route5"]:
            do {
                print("调用7")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: -1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute2()
                break
            }
        case ["route8","route6"]:
            do {
                print("调用8")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute1()
                break
            }
        case ["route8","route5"]:
            do {
                print("调用9")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute1()
                break
            }
        case ["route7","route6"]:
            do {
                print("调用10")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: -1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute2()
                break
            }
        case ["route7","route1"]:
            do {
                print("调用11")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: -1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute2()
                break
            }
        case ["route1","route8"]:
            do {
                print("调用12")
                var transform: CGAffineTransform = CGAffineTransform.identity
                transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fishView.transform = transform
                fishView.layer.removeAllAnimations()
                fishRunRoute1()
                break
            }
        default:
            print("调用默认参数")
            print(animationName)
        }
    }
}

extension FishTreeViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}
