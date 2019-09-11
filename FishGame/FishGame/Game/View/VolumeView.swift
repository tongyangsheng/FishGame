//
//  VolumeView.swift
//  FishGame
//
//  Created by game98 on 2019/8/23.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import MediaPlayer

class VolumeView: UIView
{
    let contentView = UIView()
    var slider:UISlider = UISlider()
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

extension VolumeView
{
    private func setupUI()
    {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        contentView.frame = CGRect(x: 0.255*K_ScreenW, y: (K_ScreenH - 0.387*0.49*K_ScreenW)/2, width: 0.49*K_ScreenW, height: 0.387*0.49*K_ScreenW)
        contentView.backgroundColor = .white
        contentView.center = self.center
        contentView.layer.cornerRadius = 12
        setupContentUI()
        self.addSubview(contentView)
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "关闭"), for: .normal)
        backButton.frame = CGRect(x: 0.255*K_ScreenW+0.49*K_ScreenW-0.06*contentView.frame.width, y: (K_ScreenH - 0.387*0.49*K_ScreenW)/2 - 0.02*contentView.frame.width, width: 0.08*contentView.frame.width, height: 0.08*contentView.frame.width)
        backButton.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
        self.addSubview(backButton)
    }
    private func setupContentUI()
    {
        let titleLabel = UILabel()
        titleLabel.text = "设置"
        titleLabel.font = UIFont(name: "PingFang SC", size: 18)
        titleLabel.textColor = UIColor(r: 10, g: 110, b: 203)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: (contentView.frame.width - 100)/2, y: 0.087*contentView.frame.height, width: 100, height: 20)
        contentView.addSubview(titleLabel)
        
        let underLine = UIView()
        underLine.layer.cornerRadius = 2
        underLine.backgroundColor = UIColor(r: 225, g: 241, b: 255)
        underLine.frame = CGRect(x: 0.1*contentView.frame.width, y: 0.3*contentView.frame.height, width: 0.8*contentView.frame.width, height: 4)
        contentView.addSubview(underLine)
        
        let soundIcon = UIImageView()
        soundIcon.image = UIImage(named: "声音")
        soundIcon.frame = CGRect(x: 0.15*contentView.frame.width, y: 0.6*contentView.frame.height, width: 0.082*contentView.frame.width, height: 0.082*contentView.frame.width)
        contentView.addSubview(soundIcon)
        
        slider.frame = CGRect(x: 0.3*contentView.frame.width, y: 0.6*contentView.frame.height, width: 0.55*contentView.frame.width, height: 0.2*contentView.frame.height)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(AVAudioSession.sharedInstance().outputVolume, animated: true)
        slider.minimumTrackTintColor = UIColor(r: 109, g: 177, b: 247)
        slider.addTarget(self, action: #selector(systemVolume(sender:)), for: .valueChanged)
        contentView.addSubview(slider)
    }
}

extension VolumeView
{
    private func getSystemVolumSlider() -> UISlider
    {
        let systemVolumView = MPVolumeView()
        systemVolumView.frame.size = CGSize.init(width: 200, height: 4)
        systemVolumView.center = self.center
        var volumViewSlider = UISlider()
        for subView in systemVolumView.subviews
        {
            if type(of: subView).description() == "MPVolumeSlider"
            {
                volumViewSlider = subView as! UISlider
                return volumViewSlider
            }
        }
        return volumViewSlider
    }
    
    private func getSystemVolumValue() -> Float
    {
        print(getSystemVolumSlider().value)
        return getSystemVolumSlider().value
    }
    private func setSystemVolumWith(_ value: Float)
    {
        self.getSystemVolumSlider().value = value
    }
    
    @objc func pressBack()
    {
        dismiss()
    }
    
    @objc func systemVolume(sender: UISlider)
    {
        MPVolumeView.setVolum(slider.value)
    }
}

extension VolumeView
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
