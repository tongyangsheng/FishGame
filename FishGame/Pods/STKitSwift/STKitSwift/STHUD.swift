//
//  STHUD.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 沈天
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import SnapKit
public class STHUD: UIView{
    
    // MARK: 1.lift cycle
    @discardableResult
    public class func show(_ title:String, completion:((Bool) -> Void)? = nil) -> STHUD{
        let noticeView = STHUD.init(frame: UIScreen.main.bounds)
        noticeView.setupUI()
        noticeView.labelTitle.text = title
        noticeView.show()
        noticeView.completion = completion
        return noticeView
    }
    
    // MARK: 2.private methods
    private func show()  {
        let window = UIApplication.shared.keyWindow!
        window.addSubview(self)
        self.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.layer.opacity = 1.0
        }) { (finished) in
            self.perform(#selector(self.remove), with: nil, afterDelay: 1)
        }
    }
    
    @objc private func remove(){
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.layer.opacity = 0
        }) { (finished) in
            self.removeFromSuperview()
            self.completion?(true)
        }
    }
    // MARK: 3.event response
    private func setupUI(){
        contentView.snp.makeConstraints { (maker) in
            maker.left.greaterThanOrEqualTo(50)
            maker.right.lessThanOrEqualTo(-50)
            maker.center.equalToSuperview()
        }
        
        labelTitle.snp.makeConstraints { (maker) in
            maker.left.equalTo(28)
            maker.right.equalTo(-28)
            maker.top.equalTo(14)
            maker.bottom.equalTo(-14)
        }
    }
    // MARK: 4.interface
    var completion: ((Bool) -> Void)? = nil
    // MARK: 5.getter
    private lazy var labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.font = UIFont.systemFont(ofSize: 16)
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        contentView.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        contentView.layer.masksToBounds = true
        addSubview(contentView)
        return contentView
    }()
}
