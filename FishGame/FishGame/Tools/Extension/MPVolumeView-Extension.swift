//
//  MPVolumeView-Extension.swift
//  FishGame
//
//  Created by game98 on 2019/9/11.
//  Copyright © 2019 https://github.com/tongyangsheng. All rights reserved.
//

import UIKit
import MediaPlayer

extension MPVolumeView
{
    static func setVolum(_ volum: Float)
    {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: {$0 is UISlider}) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volum
        }
    }
}
