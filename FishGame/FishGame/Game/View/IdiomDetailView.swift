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
        idiomFromLabel.numberOfLines = 3
        idiomFromLabel.font = UIFont.systemFont(ofSize: 12)
        idiomFromLabel.frame = CGRect(x: 0.05*self.frame.width, y: 0.08*self.frame.height, width: 0.9*self.frame.width, height: 0.5*self.frame.height)
        self.addSubview(idiomFromLabel)
        idiomAnalysisLabel.text = idiomAnalysis
        idiomAnalysisLabel.textColor = UIColor(r: 175, g: 168, b: 168)
        idiomAnalysisLabel.numberOfLines = 4
        idiomAnalysisLabel.font = UIFont.systemFont(ofSize: 10)
        idiomAnalysisLabel.frame = CGRect(x: 0.05*self.frame.width, y: 0.5*self.frame.height, width: 0.9*self.frame.width, height: 0.5*self.frame.height)
        self.addSubview(idiomAnalysisLabel)
    }
}
