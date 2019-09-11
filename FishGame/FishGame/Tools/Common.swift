//
//  Common.swift
//  FishGame
//
//  Created by game98 on 2019/8/15.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import AVFoundation

//底部的安全距离
let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0

//顶部的安全距离
let topSafeAreaHeight = (bottomSafeAreaHeight == 0 ? 0 : 24)

//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height;

//导航栏高度
let navigationHeight: CGFloat = (bottomSafeAreaHeight == 0 ? 64 :88)

//tabbar 高度
let tabBarHeight = (bottomSafeAreaHeight + 49)


//屏幕宽度，高度
let K_ScreenW = UIScreen.main.bounds.width
let K_ScreenH = UIScreen.main.bounds.height

//初始鱼食数量
var K_Bait = 10

//游戏等级
var K_GameProgress = 1

//成语关卡
var K_idiomProgress: Int = 1

//全局背景音乐
var K_AudioPlayer: AVAudioPlayer =
{
    let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "backMusic", ofType: "mp3")!)
    let K_AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
    K_AudioPlayer.prepareToPlay()
    K_AudioPlayer.numberOfLoops = -1
    K_AudioPlayer.play()
    return K_AudioPlayer
}()
//
var K_EarnTime = 0

