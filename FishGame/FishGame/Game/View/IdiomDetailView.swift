//
//  IdiomDetailView.swift
//  FishGame
//
//  Created by game98 on 2019/8/22.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

class IdiomDetailView: UIView
{
    var idiomFrom: String
    var idiomAnalysis: String
    var idiomMore: String
    
    let idiomFromLabel = UILabel()
    let idiomAnalysisLabel = UILabel()
    
    init(frame: CGRect,idiomFrom: String,idiomAnalysis: String, idiomMore: String)
    {
        self.idiomFrom = idiomFrom
        self.idiomAnalysis = idiomAnalysis
        self.idiomMore = idiomMore
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IdiomDetailView
{
    private func setupUI()
    {
        self.frame = frame
        self.layer.cornerRadius = 7
        self.backgroundColor = .white
        idiomFromLabel.text = idiomFrom
        idiomFromLabel.textColor = UIColor(r: 41, g: 171, b: 226)
        idiomFromLabel.numberOfLines = 2
        idiomFromLabel.font = UIFont.systemFont(ofSize: 12)
        idiomFromLabel.frame = CGRect(x: 0.05*self.frame.width, y: 0.08*self.frame.height, width: 0.9*self.frame.width, height: 0.32*self.frame.height)
        self.addSubview(idiomFromLabel)
        idiomAnalysisLabel.text = idiomAnalysis
        idiomAnalysisLabel.textColor = UIColor(r: 175, g: 168, b: 168)
        idiomAnalysisLabel.numberOfLines = 2
        idiomAnalysisLabel.font = UIFont.systemFont(ofSize: 10)
        idiomAnalysisLabel.frame = CGRect(x: 0.05*self.frame.width, y: 0.38*self.frame.height, width: 0.9*self.frame.width, height: 0.3*self.frame.height)
        self.addSubview(idiomAnalysisLabel)
        let underLine = UIView()
        underLine.backgroundColor = UIColor(r: 255, g: 241, b: 255)
        underLine.frame = CGRect(x: 0, y: 0.74*self.frame.height, width: self.frame.width, height: 2)
        self.addSubview(underLine)
        
        let moreIcon = UIImageView()
        moreIcon.image = UIImage(named: "查看详情")
        moreIcon.frame = CGRect(x: 0.3*self.frame.width, y: 0.8*self.frame.height, width: 0.053*self.frame.width, height: 0.053*self.frame.width)
        self.addSubview(moreIcon)
        let checkMoreButton = UIButton()
        checkMoreButton.setTitle("查看详情", for: .normal)
        checkMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        checkMoreButton.setTitleColor(UIColor(r: 41, g: 171, b: 226), for: .normal)
        checkMoreButton.frame = CGRect(x: 0.4*self.frame.width, y: 0.79*self.frame.height, width: 60, height: 15)
        self.addSubview(checkMoreButton)
    }
}
