//
//  LowBaitView.swift
//  FishGame
//
//  Created by game98 on 2019/8/19.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class LowBaitView: UIView
{
    let contentView = UIView()
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LowBaitView
{
    private func setupUI()
    {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        //主体弹窗
        contentView.frame = CGRect(x: 0.258*K_ScreenW, y: 0.245*K_ScreenH, width: 0.48*K_ScreenW, height: 0.504*K_ScreenH)
        contentView.center = self.center
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12.0
        setupContentUI()
        self.addSubview(contentView)
    }
    private func setupContentUI()
    {
        let backgroundColorView = UIImageView()
        backgroundColorView.backgroundColor = UIColor.init(r: 204, g: 227, b: 251)
        backgroundColorView.layer.cornerRadius = 11.0
        backgroundColorView.frame = CGRect(x: 0.006*contentView.frame.width, y: 0.01*contentView.frame.height, width: 0.988*contentView.frame.width, height: 0.98*contentView.frame.height)
        contentView.addSubview(backgroundColorView)
        
        let baitIcon = UIImageView()
        baitIcon.image = UIImage(named: "鱼食")
        baitIcon.frame = CGRect(x: (0.48*K_ScreenW-0.118*0.48*K_ScreenW)/2, y: 0.095*0.504*K_ScreenH, width: 0.118*0.48*K_ScreenW, height: 1.1*0.118*0.48*K_ScreenW)
        
        contentView.addSubview(baitIcon)
        
        let cancelButton = UIButton()
        cancelButton.setBackgroundImage(UIImage(named: "白按钮"), for: .normal)
        cancelButton.frame = CGRect(x: 0.07*contentView.frame.width, y: 0.65*contentView.frame.height, width: 0.35*contentView.frame.width, height: 0.3*0.35*contentView.frame.width)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.init(r: 128, g: 128, b: 128), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "PingFang SC", size: 18)
        cancelButton.addTarget(self, action: #selector(pressCancel(_:)), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        let goButton = UIButton()
        goButton.setBackgroundImage(UIImage(named: "蓝按钮"), for: .normal)
        goButton.frame = CGRect(x: contentView.frame.width-0.07*contentView.frame.width-0.35*contentView.frame.width, y: 0.65*contentView.frame.height, width: 0.35*contentView.frame.width, height: 0.3*0.35*contentView.frame.width)
        goButton.setTitle("去赢取", for: .normal)
        goButton.setTitleColor(UIColor.init(r: 255, g: 255, b: 255), for: .normal)
        goButton.titleLabel?.font = UIFont(name: "PingFang SC", size: 18)
        contentView.addSubview(goButton)
    }
}

extension LowBaitView
{
    @objc func pressCancel(_ button: UIButton)
    {
        self.removeFromSuperview()
    }
}

extension LowBaitView
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
