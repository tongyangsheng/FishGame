//
//  FishTreeViewController.swift
//  FishGame
//
//  Created by game98 on 2019/8/28.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
}

extension FishTreeViewController
{
    private func setupUI()
    {
        maskView.frame = UIScreen.main.bounds
        maskBackground.image = UIImage(named: "背景图")
        maskBackground.frame = CGRect(x: 0, y: 0, width: maskView.frame.width, height: maskView.frame.height)
        maskView.addSubview(maskBackground)
        maskFish.image = UIImage(named: "鱼3")
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
}

extension FishTreeViewController
{
    @objc func pressPrevious(_ button: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func pressNext(_ button: UIButton)
    {
        let FourthVC = FishFourViewController()
        self.navigationController?.pushViewController(FourthVC, animated: true)
    }
}

extension FishTreeViewController: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}
