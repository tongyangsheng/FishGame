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
    }
}
