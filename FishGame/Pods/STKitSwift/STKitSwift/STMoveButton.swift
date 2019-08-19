//
//  STMoveButton.swift
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
open class STMoveButton: UIButton{
    
    // MARK: 1.lift cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(panGesture)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 2.private methods
    
    // MARK: 3.event response
    @objc func panClick(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .possible: break
        case .began: break
        case .changed:
            let tx:CGFloat = panGesture.location(in: self).x - frame.width/2
            let ty:CGFloat = panGesture.location(in: self).y - frame.height/2
            transform = transform.translatedBy(x: tx, y: ty)
            break
        case .ended:
            var frameButton = self.frame
            let STSCREENWIDTH = UIScreen.main.bounds.width
            let STSCREENHEIGHT = UIScreen.main.bounds.height
            
            if (frameButton.origin.y < 64 ) {
                frameButton.origin.y = 64
            }
        
            if (frameButton.origin.y > (STSCREENHEIGHT - frameButton.size.height - margin)) {
                frameButton.origin.y = (STSCREENHEIGHT - frameButton.size.height - margin)
            }
            
            if (frameButton.origin.y > STSCREENWIDTH) {
                if ((frameButton.origin.x + frameButton.size.width/2) < STSCREENWIDTH/2 ) {
                    frameButton.origin.x = margin
                    autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin]
                    
                }else {
                    frameButton.origin.x = STSCREENWIDTH - frameButton.size.width - margin
                    autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
                }
            }else {
                if ((frameButton.origin.x + frameButton.size.width/2) < STSCREENWIDTH/2 ) {
                    frameButton.origin.x = margin
                    autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
                }else {
                    frameButton.origin.x = STSCREENWIDTH - frameButton.size.width - margin
                    autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                }
            }
            
            UIView.animate(withDuration: 0.3) {
                self.frame = frameButton
            }
            break
        case .cancelled: break
        case .failed: break
        @unknown default: break
            
        }
    }
    
    // MARK: 4.interface
    private lazy var panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panClick(panGesture:)))
        return panGesture
    }()
    
    open var margin:CGFloat = 16
}



