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
    private var anwserStr: String
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
        let backgroundImage = UIImageView()
        let anwserLabel = UILabel()
        
        backgroundImage.image = UIImage(named: backImageName)
        backgroundImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(backgroundImage)
        
        anwserLabel.text = anwserStr
        anwserLabel.font = UIFont.systemFont(ofSize: 18)
        switch keyValue {
        case 1:
            anwserLabel.frame = CGRect(x: 0.35*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            print("第一种鱼")
            break
        case 2:
            anwserLabel.frame = CGRect(x: 0.45*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            print("第二种鱼")
            break
        case 3:
            anwserLabel.frame = CGRect(x: 0.55*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            print("第三种鱼")
            break
        case 4:
            anwserLabel.frame = CGRect(x: 0.35*self.frame.width, y: 0.15*self.frame.height, width: 0.32*self.frame.width, height: 0.2*self.frame.height)
            print("第四种鱼")
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
