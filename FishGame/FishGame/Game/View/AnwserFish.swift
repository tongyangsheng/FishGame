//
//  AnwserFish.swift
//  FishGame
//
//  Created by game98 on 2019/8/26.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class AnwserFish: UIView
{
    public var anwserStr: String
    private var backImageName: String
    private var keyValue: Int
    
    init(frame: CGRect, anwserStr: String, backImageName: String, keyValue: Int)
    {
        self.anwserStr = anwserStr
        self.backImageName = backImageName
        self.keyValue = keyValue
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnwserFish
{
    private func setupUI()
    {
        self.frame = frame
        let backgroundButton = UIButton()
        let anwserLabel = UILabel()
        
        backgroundButton.setBackgroundImage(UIImage(named: backImageName), for: .normal)
        backgroundButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backgroundButton.addTarget(self, action: #selector(fishClick), for: .touchUpInside)
        self.addSubview(backgroundButton)
        
        anwserLabel.text = anwserStr
        anwserLabel.font = UIFont.systemFont(ofSize: 18)
        switch keyValue {
        case 1:
            anwserLabel.frame = CGRect(x: 0.35*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            break
        case 2:
            anwserLabel.frame = CGRect(x: 0.45*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            break
        case 3:
            anwserLabel.frame = CGRect(x: 0.55*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            break
        case 4:
            anwserLabel.frame = CGRect(x: 0.35*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            break
        default:
            anwserLabel.frame = CGRect(x: 0.35*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            break
        }
        anwserLabel.textAlignment = .center
        anwserLabel.textColor = .white
        self.addSubview(anwserLabel)
    }
}

extension AnwserFish
{
    @objc func fishClick()
    {
        print("点击鱼")
    }
}
