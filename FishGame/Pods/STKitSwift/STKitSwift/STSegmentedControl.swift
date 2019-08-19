//
//  STSegmentedControl.swift
//  STKitSwift
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
@IBDesignable public class STSegmentedControl: UIView {
    
    // MARK: 1.lift cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 2.private methods
    func getWidth(string: String, font: UIFont, height: CGFloat = 15) -> CGFloat {
        let rect = NSString(string: string).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    // MARK: 3.event response
    
    @objc func actionClick(_ gesture: UITapGestureRecognizer) {
        let index = (gesture.view?.tag)!  - subViewTag
        selectBlock?(index)
        self.currentIndex = index
    }
    
    // MARK: 4.public interface
    public var colorTitleDefault: UIColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 1)
    public var fontDefault: UIFont = UIFont.systemFont(ofSize: 17)
    
    public var colorTitleSelected: UIColor = UIColor.init(red: 242.0/255, green: 96.0/255, blue: 91.0/255, alpha: 1)
    public var fontSelected: UIFont = UIFont.systemFont(ofSize: 19)
    
    public var heightTitle: CGFloat = 36
    public var titles:[String]? {
        didSet{
            if titles != nil && (titles?.count ?? 0) > 0 {
                _ = contentView.subviews.map { $0.removeFromSuperview()}
                subViews.removeAll()

                var subViewX:CGFloat = 0
                let subViewY:CGFloat = 0
                for title in titles ?? [] {
                    let subView = UILabel()
                    subView.text = title
                    subView.textAlignment = .center
                    subView.isUserInteractionEnabled = true
                    subView.font = fontDefault
                    subView.textColor = colorTitleDefault
                    subView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionClick(_:))))
                    let number = titles?.firstIndex(of: title) ?? 0
                    subView.tag = subViewTag + number
                    contentView.addSubview(subView)
                    subViews.append(subView)
                    var font = fontDefault
                    if fontSelected.pointSize > fontDefault.pointSize {
                        font = fontSelected
                    }
                    var subViewW:CGFloat = getWidth(string: title, font: font) + 8
                    if subViewW <= 60 {
                        subViewW = 60
                    }
                    subView.frame = CGRect.init(x: subViewX, y: subViewY, width: subViewW, height: heightTitle)
                    subViewX += subViewW
                }
                contentView.contentSize = CGSize.init(width: subViewX, height: 0)
                self.currentIndex = 0
            }else{
                _ = contentView.subviews.map { $0.removeFromSuperview()}
                subViews.removeAll()
            }
        }
    }


    public var selectBlock:((_ index:Int)->())?
    public var currentIndex:Int? {
        didSet{
            let index = currentIndex ?? 0
            UIView.animate(withDuration: 0.3, animations: {
                _ = self.subViews.map({ (label) in
                    label.textColor = self.colorTitleDefault
                    label.font = self.fontDefault
                })
                
                if self.subViews.count > 0 {
                    self.subViews[index].textColor = self.colorTitleSelected
                    self.subViews[index].font = self.fontSelected
                }
            }) { (finish) in
                if self.contentView.contentSize.width > UIScreen.main.bounds.width{
                    var offsetX = self.subViews[index].st_centerX - self.contentView.st_centerX
                    if offsetX < 0 {
                        offsetX = 0
                    }
                    if offsetX > (self.contentView.contentSize.width - self.contentView.st_width) {
                        offsetX = (self.contentView.contentSize.width - self.contentView.st_width)
                    }
                    self.contentView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
                }
            }
        }
    }
    
    // MARK: 5.private interface
    private var subViews:[UILabel] = []
    private let subViewTag: Int = 11000
    
    private lazy var contentView:UIScrollView = {
        let contentView = UIScrollView()
        contentView.showsHorizontalScrollIndicator = false
        addSubview(contentView)
        return contentView
    }()
}
