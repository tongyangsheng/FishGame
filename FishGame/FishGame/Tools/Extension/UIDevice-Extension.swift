//
//  UIDevice-Extension.swift
//  FishGame
//
//  Created by game98 on 2019/8/15.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit

extension UIDevice
{
    public func isX() -> Bool
    {
        if bottomSafeAreaHeight != 0
        {
            return true
        }
        return false
    }
}
