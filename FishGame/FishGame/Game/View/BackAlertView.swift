//
//  backAlertView.swift
//  FishGame
//
//  Created by game98 on 2019/8/27.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class BackAlertView: UIView
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

extension BackAlertView
{
    private func setupUI()
    {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        contentView.frame = CGRect(x: 0.26*K_ScreenW, y: (K_ScreenH - 0.564*0.48*K_ScreenW)/2, width: 0.48*K_ScreenW, height: 0.564*0.48*K_ScreenW)
        contentView.backgroundColor = .white
        contentView.center = self.center
        contentView.layer.cornerRadius = 12
        setupContentUI()
        self.addSubview(contentView)
    }
    private func setupContentUI()
    {
        let backgroundColorView = UIImageView()
        backgroundColorView.backgroundColor = UIColor.init(r: 204, g: 227, b: 251)
        backgroundColorView.layer.cornerRadius = 11.0
        backgroundColorView.frame = CGRect(x: 0.012*contentView.frame.width, y: 0.02*contentView.frame.height, width: 0.976*contentView.frame.width, height: 0.96*contentView.frame.height)
        contentView.addSubview(backgroundColorView)
        
        let titleLable = UILabel()
        titleLable.text = "确认退出吗？"
        titleLable.textColor = UIColor(r: 10, g: 110, b: 203)
        titleLable.textAlignment = .center
        titleLable.font = UIFont(name: "PingFang SC", size: 22)
        titleLable.frame = CGRect(x: 0.012*contentView.frame.width, y: 0.15*contentView.frame.height, width: 0.976*contentView.frame.width, height: 0.15*contentView.frame.height)
        contentView.addSubview(titleLable)
        
        let alertLabel = UILabel()
        alertLabel.text = "退出将会失去本局的鱼食奖励哦！"
        alertLabel.textColor = UIColor(r: 128, g: 128, b: 128)
        alertLabel.textAlignment = .center
        alertLabel.font = UIFont(name: "PingFang SC", size: 18)
        alertLabel.frame = CGRect(x: 0.012*contentView.frame.width, y: 0.4*contentView.frame.height, width: 0.976*contentView.frame.width, height: 0.15*contentView.frame.height)
        contentView.addSubview(alertLabel)
        
        let confirmButton = UIButton()
        let cancelButton = UIButton()
        
        confirmButton.setBackgroundImage(UIImage(named: "白按钮"), for: .normal)
        confirmButton.setTitle("是", for: .normal)
        confirmButton.setTitleColor(UIColor(r: 128, g: 128, b: 128), for: .normal)
        confirmButton.frame = CGRect(x: 0.6*contentView.frame.width, y: 0.7*contentView.frame.height, width: 0.3*contentView.frame.width, height: 0.35*0.3*contentView.frame.width)
        confirmButton.addTarget(self, action: #selector(pressConfirm(_:)), for: .touchUpInside)
        contentView.addSubview(confirmButton)
        
        cancelButton.setBackgroundImage(UIImage(named: "蓝按钮"), for: .normal)
        cancelButton.setTitle("否", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.frame = CGRect(x: 0.1*contentView.frame.width, y: 0.7*contentView.frame.height, width: 0.3*contentView.frame.width, height: 0.35*0.3*contentView.frame.width)
        cancelButton.addTarget(self, action: #selector(pressCancel(_:)), for: .touchUpInside)
        contentView.addSubview(cancelButton)
    }
}

extension BackAlertView
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

extension BackAlertView
{
    @objc func pressCancel(_ button: UIButton)
    {
        dismiss()
    }
    @objc func pressConfirm(_ button: UIButton)
    {
        NotificationCenter.default.post(name: NSNotification.Name("confirmQuit"), object: self, userInfo: ["post":"NewTest"])
        dismiss()
    }
}


