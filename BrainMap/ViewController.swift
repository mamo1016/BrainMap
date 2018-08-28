//
//  ViewController.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/21.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Screen Size の取得
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var circleArray:[Draw] = []
    var draw: Draw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height

        // 画面背景を設定
        self.view.backgroundColor = UIColor(red:0.85,green:1.0,blue:0.95,alpha:1.0)
        
            createCircle(x: 100, y: 100) //タッチした座標にしたい

        }
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
//        createCircle(x: 100, y: 100) //タッチした座標にしたい
}
    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y
        
        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        draw.move(x: newDx, y: newDy)
        self.view.addSubview(draw)
        
        print(newDx,newDy)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createCircle(x: CGFloat, y: CGFloat){
        draw = Draw(frame: CGRect(x: x-25, y: y-25, width: screenWidth, height: screenHeight))
//        draw.roundRect.move(to: CGPoint(x:200,y:300))
        circleArray.append(draw)
        self.view.addSubview(draw)
        if circleArray.count >= 2{
//            circleArray[0].removeFromSuperview()
//            circleArray.remove(at: 0)
        }

        // 不透明にしない（透明）
        draw.isOpaque = false
    }
    
}

