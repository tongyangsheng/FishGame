//
//  ScreenShotView.swift
//  FishGame
//
//  Created by game98 on 2019/8/20.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import Toast_Swift

class ScreenShotView: UIView
{
    private var fishTypeImageStr: String
    
    let contentBackgroundImage = UIImageView()
    let contentView = UIView()
    let fishImageView = UIImageView()
    let saveButton = UIButton()
    let shareButton = UIButton()
    let quitButton = UIButton()
    let fishProgressLabel = UILabel()
    
    init(frame: CGRect, fishTypeImageStr: String)
    {
        self.fishTypeImageStr = fishTypeImageStr
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ScreenShotView
{
    private func setupUI()
    {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        //主体弹窗
        contentView.frame = CGRect(x: 0.4*K_ScreenW, y: 0.03*K_ScreenH, width: 0.2*K_ScreenW, height: 1.75*0.2*K_ScreenW)
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 12.0
        setupContentUI()
        self.addSubview(contentView)
        fishImageView.frame = CGRect(x: 0.065*K_ScreenW, y: 0.2*K_ScreenH, width: 0.08*K_ScreenW, height: 0.65*0.08*K_ScreenW)
        fishImageView.image = UIImage(named: fishTypeImageStr)
        contentView.addSubview(fishImageView)
        //保存按钮
        saveButton.frame = CGRect(x: 0.28*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        saveButton.setImage(UIImage(named: "保存图片"), for: .normal)
        self.addSubview(saveButton)
        //分享按钮
        shareButton.frame = CGRect(x: K_ScreenW - 0.28*K_ScreenW - 0.2*K_ScreenW, y: 0.787*K_ScreenH, width: 0.2*K_ScreenW, height: 0.16*K_ScreenH)
        shareButton.setImage(UIImage(named: "分享"), for: .normal)
        saveButton.addTarget(self, action: #selector(chageToImageAndSave), for: .touchUpInside)
        self.addSubview(shareButton)
        //关闭按钮
        quitButton.frame = CGRect(x: K_ScreenW - 0.057*K_ScreenW - 0.027*K_ScreenW , y: 0.04*K_ScreenH, width: 0.057*K_ScreenW, height: 0.057*K_ScreenW)
        quitButton.setImage(UIImage(named: "关闭"), for: .normal)
        quitButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        self.addSubview(quitButton)
    }
    private func setupContentUI()
    {
        contentBackgroundImage.image = UIImage(named: "拍照背景图")
        contentBackgroundImage.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentBackgroundImage.backgroundColor = .green
        contentBackgroundImage.layer.cornerRadius = 12.0
        contentBackgroundImage.layer.masksToBounds = true
        contentView.addSubview(contentBackgroundImage)
    }
}

extension ScreenShotView
{
    public func show()
    {
        self.alpha = 0
        contentView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        }
        if let window = UIApplication.shared.keyWindow
        {
            window.addSubview(self)
        }
    }
    @objc public func dismiss()
    {
        self.removeFromSuperview()
    }
    
    @objc public func chageToImageAndSave()
    {
        let saveImage: UIImage = getImageFromView(view: contentView)
        UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil)
        self.makeToast("图片已保存至相册")
    }
}

extension ScreenShotView
{
        func getImageFromView(view: UIView) -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

