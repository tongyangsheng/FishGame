//
//  MainGameViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/22.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import Lottie

class MainGameViewController: UIViewController
{
    let darkCloudView = AnimationView()
    let waveView = AnimationView()
    let backgroundImage = UIImageView()
    let backButton = UIButton()
    let settingButton = UIButton()
    let BaitNumberView = UIView()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
}

extension MainGameViewController
{
    private func setupUI()
    {
        let cloudAnimation = Animation.named("leidian_x")
        darkCloudView.animation = cloudAnimation
        darkCloudView.contentMode = .scaleToFill
        darkCloudView.play()
        darkCloudView.loopMode = .loop
        darkCloudView.frame = CGRect(x: 0, y: -10, width: K_ScreenW+10, height: K_ScreenH)
        
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
        self.view.addSubview(settingButton)
        
        BaitNumberView.frame = CGRect(x: settingButton.frame.origin.x + 0.05*K_ScreenW + 0.0255*K_ScreenW, y: 0.035*K_ScreenH, width: 0.12*K_ScreenW, height: 0.4375*0.12*K_ScreenW)
        let BaitNumberImage = UIImageView()
        BaitNumberImage.image = UIImage(named: "鱼食数目")
        BaitNumberImage.frame = CGRect(x: 0, y: 0, width: 0.12*K_ScreenW, height: 0.4375*0.12*K_ScreenW)

        BaitNumberView.addSubview(BaitNumberImage)
        self.view.addSubview(BaitNumberView)
        
        let idiomFrame = CGRect(x: 0.355*K_ScreenW, y: 0.035*K_ScreenH, width: 0.29*K_ScreenW, height: 0.21*0.29*K_ScreenW)
        let showIdiomView = idiomView(frame: idiomFrame, idiomStr: "学富五车")
        self.view.addSubview(showIdiomView)
        
        let idiomDetailFrame = CGRect(x: K_ScreenW-0.28*K_ScreenW-0.0225*K_ScreenW, y: 0.1*K_ScreenH, width: 0.28*K_ScreenW, height: 0.473*0.28*K_ScreenW)
        let idiomDetailView = IdiomDetailView(frame: idiomDetailFrame, idiomFrom: "源自：《庄子·天下》：“惠施多方，其书五车。”", idiomAnalysis: "解析：五车：五车书。原指庄子形容惠施的学问有五车书那么多，现形容读书多，学识丰富。", idiomMore: "1")
        self.view.addSubview(idiomDetailView)
    }
}

extension MainGameViewController
{
    @objc func pressBack(_ button:UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
