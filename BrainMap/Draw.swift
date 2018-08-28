//
//  Draw.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/21.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

class Draw: UIView {
    
    var roundRect: UIBezierPath!
    
    override func draw(_ rect: CGRect) {
        // 角が丸い矩形 -------------------------------------
        roundRect = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 50), cornerRadius: 25)
        // stroke 色の設定
        UIColor(red: 0.3, green: 1, blue: 0.2, alpha: 1).setStroke()
        roundRect.lineWidth = 2
        roundRect.stroke()
        print("Draw")
        
//        roundRect.move(to: CGPoint(x:0,y:0))
//
    }

    func move(x: CGFloat,y: CGFloat){
        roundRect.move(to: CGPoint(x:x,y:y))
    }
}
