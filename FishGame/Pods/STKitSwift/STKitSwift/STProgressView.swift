//
//  STProgressView.swift
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

@IBDesignable public class STProgressView: UIView {
    // MARK: 1.lift cycle
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
        layer.masksToBounds = true
        progressLayer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 2.private methods
    override public func draw(_ rect: CGRect) {
        var frameprogress = rect
        frameprogress.size.width = progress * rect.width
        progressLayer.frame = frameprogress
        progressLayer.colors = [startColor.cgColor, endColor.cgColor]
        progressLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
    // MARK: 3.event response
    
    // MARK: 4.interface
    @IBInspectable public var startColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var endColor: UIColor = .yellow {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: 5.getter
    private lazy var progressLayer: CAGradientLayer = {
        let progressLayer = CAGradientLayer()
        progressLayer.frame = CGRect.zero
        progressLayer.locations = [0, 1]
        progressLayer.startPoint = CGPoint(x: 0, y: 1)
        progressLayer.endPoint = CGPoint(x: 1, y: 1)
        return progressLayer
    }()
}
