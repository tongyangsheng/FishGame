//
//  ResultView.swift
//  FishGame
//
//  Created by game98 on 2019/8/27.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class ResultView: UIView
{
    private var BaitNumber: Int
    let contentView = UIView()
    init(frame: CGRect,BaitNumber: Int)
    {
        self.BaitNumber = BaitNumber
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultView
{
    private func setupUI()
    {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        contentView.frame = CGRect(x: 0.21*K_ScreenW, y: (K_ScreenH - 0.634*0.58*K_ScreenW)/2, width: 0.58*K_ScreenW, height: 0.634*0.58*K_ScreenW)
        contentView.backgroundColor = .white
        contentView.center = self.center
        contentView.layer.cornerRadius = 12
        setupContentUI()
        self.addSubview(contentView)
    }
    private func setupContentUI()
    {
        let backgroundColorView = UIImageView()
        backgroundColorView.image = UIImage(named: "获得鱼食")
        backgroundColorView.layer.cornerRadius = 11.0
        backgroundColorView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(backgroundColorView)
        
        let titleLable = UILabel()
        titleLable.text = "恭喜获得\(BaitNumber)g鱼食"
        titleLable.textColor = UIColor(r: 10, g: 110, b: 203)
        titleLable.textAlignment = .center
        titleLable.font = UIFont(name: "PingFang SC", size: 22)
        titleLable.frame = CGRect(x: 0.012*contentView.frame.width, y: 0.06*contentView.frame.height, width: 0.976*contentView.frame.width, height: 0.15*contentView.frame.height)
        contentView.addSubview(titleLable)
        
        let baitNumberLabel = UILabel()
        baitNumberLabel.text = BaitNumber.description
        baitNumberLabel.textColor = UIColor(r: 255, g: 230, b: 90)
        baitNumberLabel.textAlignment = .center
        baitNumberLabel.font = UIFont(name: "PingFang SC", size: 40)
        baitNumberLabel.frame = CGRect(x: 0.35*contentView.frame.width, y: 0.35*contentView.frame.height, width: 0.3*contentView.frame.width, height: 0.3*contentView.frame.height)
        contentView.addSubview(baitNumberLabel)
        
        let nextPartButton = UIButton()
        let backButton = UIButton()
        
        nextPartButton.setBackgroundImage(UIImage(named: "蓝按钮"), for: .normal)
        nextPartButton.setTitle("下一轮", for: .normal)
        nextPartButton.setTitleColor(.white, for: .normal)
        nextPartButton.frame = CGRect(x: 0.6*contentView.frame.width, y: 0.7*contentView.frame.height, width: 0.3*contentView.frame.width, height: 0.35*0.3*contentView.frame.width)
        nextPartButton.addTarget(self, action: #selector(pressNext(_:)), for: .touchUpInside)
        contentView.addSubview(nextPartButton)
        
        backButton.setBackgroundImage(UIImage(named: "白按钮"), for: .normal)
        backButton.setTitle("返回" ,for: .normal)
        backButton.setTitleColor(UIColor(r: 128, g: 128, b: 128), for: .normal)
        backButton.frame = CGRect(x: 0.1*contentView.frame.width, y: 0.7*contentView.frame.height, width: 0.3*contentView.frame.width, height: 0.35*0.3*contentView.frame.width)
        backButton.addTarget(self, action: #selector(pressBack(_:)), for: .touchUpInside)
        contentView.addSubview(backButton)
    }
}

extension ResultView
{
    public func show()
    {
        self.alpha = 0
        contentView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        }
        if let window = UIApplication.shared.keyWindow
        {
            window.addSubview(self)
        }
    }
    public func dismiss()
    {
        self.removeFromSuperview()
    }
}

extension ResultView
{
    @objc func pressBack(_ button: UIButton)
    {
        NotificationCenter.default.post(name: NSNotification.Name("finishEarn"), object: self, userInfo: ["post":"NewTest"])
        dismiss()
    }
    @objc func pressNext(_ button: UIButton)
    {
        dismiss()
    }
}
