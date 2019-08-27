//
//  MainGameViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/22.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import Lottie
import STKitSwift
import SwiftyJSON

class MainGameViewController: UIViewController
{
    let darkCloudView = AnimationView()
    let waveView = AnimationView()
    let backgroundImage = UIImageView()
    let backButton = UIButton()
    let settingButton = UIButton()
    let BaitNumberView = UIView()
    let BaitNumberLabel = UILabel()
    
    let showIdiomView = idiomView(frame: CGRect(x: 0.355*K_ScreenW, y: 0.03*K_ScreenH, width: 0.29*K_ScreenW, height: 0.21*0.29*K_ScreenW), idiomStr: "学富五车")
    
    var countdownTimer = Timer()
    var countdownSeconds: Double = 60
    var countdownLabel: UILabel = UILabel(frame: CGRect(x: 0.15*0.28*K_ScreenW, y: (0.128*0.28*K_ScreenW-20)/2, width: 30, height: 20))
    
    
    lazy var path = Bundle.main.path(forResource: "Question", ofType: "json")
    lazy var jsonData = NSData(contentsOfFile: path!)
    lazy var json = JSON(jsonData!)
    
    lazy var earnBait: Int = 0
    lazy var questionNumber: Int = 0
    
    private lazy var progressView: STProgressView = {
        let progressView = STProgressView()
        progressView.backgroundColor = UIColor.init(r: 204, g: 204, b: 204)
        progressView.startColor = UIColor.init(r: 255, g: 183, b: 39)
        
        progressView.endColor = UIColor.init(r: 255, g: 183, b: 39)
        
        progressView.cornerRadius = 11
        progressView.progress = 1
        self.view.addSubview(progressView)
        return progressView
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        loadQuestion()
    }
}

extension MainGameViewController
{
    private func setupUI()
    {
        let cloudAnimation = Animation.named("leidian_x")
        darkCloudView.animation = cloudAnimation
        darkCloudView.contentMode = .scaleToFill
        darkCloudView.stop()
        darkCloudView.loopMode = .loop
        darkCloudView.frame = CGRect(x: 0, y: -10, width: K_ScreenW+10, height: K_ScreenH)
        darkCloudView.alpha = 0.0
        
        let waveAnimation = Animation.named("bolan_x")
        let imageProvider1 = BundleImageProvider(bundle: Bundle.main, searchPath: "img_0")
        let imageProvider2 = BundleImageProvider(bundle: Bundle.main, searchPath: "img_1")
        let imageProvider3 = BundleImageProvider(bundle: Bundle.main, searchPath: "img_2")
        waveView.imageProvider = imageProvider1
        waveView.imageProvider = imageProvider2
        waveView.imageProvider = imageProvider3
        waveView.animation = waveAnimation
        waveView.contentMode = .scaleToFill
        waveView.play()
        waveView.loopMode = .loop
        waveView.frame = CGRect(x: 0, y: 0, width: K_ScreenW, height: K_ScreenH)
        
        backgroundImage.image = UIImage(named:"游戏背景图")
        backgroundImage.frame = UIScreen.main.bounds
        self.view.addSubview(backgroundImage)
        self.view.addSubview(darkCloudView)
        self.view.addSubview(waveView)
        
        backButton.setImage(UIImage(named: "返回"), for: .normal)
        backButton.frame = CGRect(x: 0.0225*K_ScreenW, y: 0.035*K_ScreenH, width: 0.05*K_ScreenW, height: 0.05*K_ScreenW*1.09)
        backButton.addTarget(self, action: #selector(pressBack(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        settingButton.setImage(UIImage(named: "设置"), for: .normal)
        settingButton.frame = CGRect(x: backButton.frame.origin.x+0.05*K_ScreenW+0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.05*K_ScreenW, height: 0.05*K_ScreenW*1.09)
        settingButton.addTarget(self, action: #selector(pressSetting(_:)), for: .touchUpInside)
        self.view.addSubview(settingButton)
        
        BaitNumberView.frame = CGRect(x: settingButton.frame.origin.x + 0.05*K_ScreenW + 0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.12*K_ScreenW, height: 0.4375*0.12*K_ScreenW)
        let BaitNumberImage = UIImageView()
        BaitNumberImage.image = UIImage(named: "鱼食数目")
        BaitNumberImage.frame = CGRect(x: 0, y: 0, width: 0.12*K_ScreenW, height: 0.4375*0.12*K_ScreenW)
        BaitNumberLabel.text = earnBait.description
        BaitNumberLabel.font = UIFont.systemFont(ofSize: 26)
        BaitNumberLabel.textColor = UIColor(r: 35, g: 162, b: 220)
        BaitNumberLabel.textAlignment = .center
        BaitNumberLabel.frame = CGRect(x: 0.6*BaitNumberView.frame.width, y: 0.12*BaitNumberView.frame.height, width: 0.3*BaitNumberView.frame.width, height: 0.8*BaitNumberView.frame.height)
        BaitNumberView.addSubview(BaitNumberImage)
        BaitNumberView.addSubview(BaitNumberLabel)
        self.view.addSubview(BaitNumberView)
        
        let idiomFrame = CGRect(x: 0.355*K_ScreenW, y: 0.03*K_ScreenH, width: 0.29*K_ScreenW, height: 0.21*0.29*K_ScreenW)
        showIdiomView.frame = idiomFrame
        self.view.addSubview(showIdiomView)
        
        let idiomDetailFrame = CGRect(x: K_ScreenW-0.28*K_ScreenW-0.0225*K_ScreenW, y: 0.15*K_ScreenH, width: 0.28*K_ScreenW, height: 0.4*0.28*K_ScreenW)
        let idiomDetailView = IdiomDetailView(frame: idiomDetailFrame, idiomFrom: "源自：《庄子·天下》：“惠施多方，其书五车。”", idiomAnalysis: "解析：五车：五车书。原指庄子形容惠施的学问有五车书那么多，现形容读书多，学识丰富。", idiomMore: "1")
        self.view.addSubview(idiomDetailView)
        
        let countdownView: UIView = UIView(frame: CGRect(x: K_ScreenW-0.28*K_ScreenW-0.0225*K_ScreenW, y: 0.05*K_ScreenH, width: 0.28*K_ScreenW, height: 0.128*0.28*K_ScreenW))
        let countdownImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0.28*K_ScreenW, height: 0.128*0.28*K_ScreenW))
        countdownImage.image = UIImage(named: "时间条")
        countdownView.addSubview(countdownImage)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainGameViewController.CLOCK), userInfo: nil, repeats: true)
        countdownLabel.textColor = UIColor(r: 41, g: 171, b: 226)
        countdownLabel.font = UIFont.systemFont(ofSize: 14)
        countdownView.addSubview(countdownLabel)
        progressView.frame = CGRect(x: 0.28*countdownView.frame.width, y: 0.13*countdownView.frame.height, width: 0.7*countdownView.frame.width, height: 0.7*countdownView.frame.height)
        countdownView.addSubview(progressView)
        self.view.addSubview(countdownView)
    }
}

extension MainGameViewController
{
    private func loadQuestion()
    {
        guard let json = json["gameTest"][questionNumber]["question"].string else { print("已加载所有题目"); return }
        showIdiomView.setTitle(json)
        createFish()
    }
    private func createFish()
    {
        for (key,subJson):(String, JSON) in json["gameTest"][questionNumber]["questionAnwser"]
        {
            let keyTag = Int(key)! + 1
            let keyValue: Int
            if Int(key)! <= 3
            {
                keyValue = Int(key)! + 1
            }
            else
            {
                keyValue = Int(key)! - 4 + 1
            }
            
            let min1: UInt32 = 1
            let max1: UInt32 = 5
            let randomFish = String(arc4random_uniform(max1 - min1) + min1)
            let fishImageName = "文字鱼"+randomFish

            let fishXpoint: CGFloat
            let fishYpoint: CGFloat
            
            switch keyTag
            {
            case 1:
                fishXpoint = -0.2*K_ScreenW
                fishYpoint = 0.5*K_ScreenH
                break
            case 2:
                fishXpoint = -0.3*K_ScreenW
                fishYpoint = 0.6*K_ScreenH
                break
            case 3:
                fishXpoint = -0.35*K_ScreenW
                fishYpoint = 0.7*K_ScreenH
                break
            case 4:
                fishXpoint = -0.45*K_ScreenW
                fishYpoint = 0.55*K_ScreenH
                break
            case 5:
                fishXpoint = -0.5*K_ScreenW
                fishYpoint = 0.7*K_ScreenH
                break
            case 6:
                fishXpoint = -0.58*K_ScreenW
                fishYpoint = 0.5*K_ScreenH
                break
            case 7:
                fishXpoint = -0.67*K_ScreenW
                fishYpoint = 0.7*K_ScreenH
                break
            case 8:
                fishXpoint = -0.78*K_ScreenW
                fishYpoint = 0.45*K_ScreenH
                break
            default:
                fishXpoint = -0.88*K_ScreenW
                fishYpoint = 0.5*K_ScreenH
                break
            }
            
            let fishFrame = CGRect(x: fishXpoint, y: fishYpoint, width: 0.07*K_ScreenW, height: 1.25*0.07*K_ScreenW)
            let anwserFish = AnwserFish(frame: fishFrame, anwserStr:subJson["anwser"].string! , backImageName: fishImageName, keyValue: keyValue)
            let result = subJson["result"].string!
            if result == "true"
            {
                anwserFish.tag = 111
            }
            else
            {
                anwserFish.tag = 200 + keyTag
            }
            self.view.addSubview(anwserFish)
            let animation = CAKeyframeAnimation(keyPath: "position")
            let startValue: NSValue = NSValue(cgPoint: anwserFish.layer.position)
            let endValue: NSValue = NSValue(cgPoint: CGPoint(x: anwserFish.layer.position.x + 1.8*K_ScreenW, y: anwserFish.layer.position.y))
            animation.values = [startValue,endValue]
            
            animation.autoreverses = false
            
            let max2: UInt32 = 30
            
            let min2: UInt32 = 20
            
            animation.duration = CFTimeInterval(arc4random_uniform(max2 - min2) + min2)

            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            anwserFish.layer.add(animation, forKey: "fishroute")
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.fishClick(tapGes:)))
            self.view.addGestureRecognizer(tapGes)
        }
    }
}

extension MainGameViewController
{
    @objc func pressBack(_ button:UIButton)
    {
        let alertView = BackAlertView()
        alertView.show()
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"confirmQuit"), object: nil)
    }
    
    @objc func pressSetting(_ button:UIButton)
    {
        let volumeView = VolumeView()
        volumeView.show()
    }
    @objc func CLOCK()
    {
        countdownSeconds -= 1
        let countdownSecondsInt = Int(countdownSeconds)
        countdownLabel.text = "\(String(countdownSecondsInt))S"
        let progressNow = countdownSeconds/60.0
        progressView.progress = CGFloat(progressNow)
        if countdownSeconds == 0
        {
            let alertView = ResultView(frame: UIScreen.main.bounds, BaitNumber: earnBait)
            alertView.show()
            countdownLabel.text = "END"
            countdownTimer.invalidate()
            NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"finishEarn"), object: nil)
        }
    }
    @objc private func fishClick(tapGes: UITapGestureRecognizer)
    {
        let touchPoint = tapGes.location(in: self.view)
        
        for subView in self.view.subviews
        {
            if ((subView.layer.presentation()?.hitTest(touchPoint)) != nil)
            {
                if subView.tag >= 100
                {
                    if subView.tag == 111
                    {
                        subView.layer.removeAllAnimations()
                        subView.frame = subView.layer.presentation()!.frame
                        for tagValue in 200...210
                        {
                            let falseView = self.view.viewWithTag(tagValue)
                            falseView?.removeFromSuperview()
                        }
                        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
                            subView.frame = CGRect(x: subView.frame.origin.x, y: subView.frame.origin.y - 0.4*K_ScreenH, width: subView.frame.size.width, height: subView.frame.size.height)
                            subView.alpha = 0
                        }, completion: nil)
                        earnBait += 1
                        BaitNumberLabel.text = earnBait.description
                        questionNumber += 1
                        loadQuestion()
                        print("点击了正确答案！")
                    }
                    else
                    {
                        darkCloudView.play()
                        darkCloudView.alpha = 1.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
                        {
                            self.darkCloudView.alpha = 0.0
                            self.darkCloudView.stop()
                        }
                        print("错误答案！")
                    }
                }
            }
        }
    }
}

extension MainGameViewController
{
        @objc func test(nofi : Notification)
        {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.removeObserver(self)
        }
}


