//
//  idiomView.swift
//  FishGame
//
//  Created by game98 on 2019/8/22.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class idiomView: UIView
{
    public var idiomStr: String
    let idiomLabel = UILabel()
    
    init(frame: CGRect, idiomStr: String)
    {
        self.idiomStr = idiomStr
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension idiomView
{
    private func setupUI()
    {
        self.frame = frame
        let idiomBackground = UIImageView()
        idiomBackground.image = UIImage(named: "横幅")
        idiomBackground.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(idiomBackground)
        idiomLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0.9*self.frame.height)
        idiomLabel.text = idiomStr
        idiomLabel.textAlignment = .center
        idiomLabel.textColor = .white
        idiomLabel.font = UIFont(name: "PingFang SC", size: 22)
        self.addSubview(idiomLabel)
    }
    
    public func setTitle(_ idiomStr: String)
    {
        idiomLabel.text = idiomStr
    }
}
