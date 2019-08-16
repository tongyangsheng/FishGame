//
//  BubbleView.swift
//  FishGame
//
//  Created by game98 on 2019/8/16.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class BubbleView: UIView
{
    
    private var idiom: String

    init(frame: CGRect, idiom: String)
    {
        self.idiom = idiom
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BubbleView
{
    private func setupUI()
    {
        let BubbleImageView = UIImageView()
        BubbleImageView.frame = self.bounds
        BubbleImageView.image = UIImage(named: "说话气泡1")
        self.addSubview(BubbleImageView)
        
        let BubbleLabel = UILabel()
        BubbleLabel.frame = CGRect(x: (0.135*K_ScreenW-100)/2, y: (0.72*0.135*K_ScreenW-5)/2 - 3, width: 100, height: 5)
        BubbleLabel.text = idiom
        BubbleLabel.textColor = .white
        BubbleLabel.font = UIFont.systemFont(ofSize: 16)
        BubbleLabel.textAlignment = .center
        self.addSubview(BubbleLabel)
    }
}
