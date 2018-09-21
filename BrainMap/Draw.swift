//
//  Draw.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/21.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

extension UIView {
    func parentViewController() -> UIViewController? {

        var parentResponder: UIResponder? = self

        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
            parentResponder = nextResponder
        }
    }
}

class Draw: UIView {
    var X: CGFloat!
    var Y: CGFloat!

    
    enum BehaviorMode : Int{
        case None
        case MoveWindowPosition
        case ChangeWindowSize
    }
    
    var roundRect: UIBezierPath!
    private var behaviorMode:BehaviorMode = .None
    
    private var locationInitialTouch:CGPoint!

    override func draw(_ rect: CGRect) {
        let random: [CGFloat] = [CGFloat(arc4random_uniform(10)), CGFloat(arc4random_uniform(10)), CGFloat(arc4random_uniform(10))]
        
        // 角が丸い矩形 -------------------------------------
        roundRect = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 50, height: 50), cornerRadius: 25)

//        let line = UIBezierPath();
//        // 起点
//        line.move(to: frame.origin);
//        // 帰着点
//        line.addLine(to: CGPoint(x: 0, y: 0));
//        // ライン幅
//        line.lineWidth = 4
//        // 描画
//        line.stroke();
        // stroke 色の設定
//        UIColor(red: 0.3, green: 1, blue: 0.2, alpha: 1).setStroke()
        // 塗りつぶし色の設定
//        UIColor(red: 0.5, green: 0.8, blue: 0.2, alpha: 1).setFill()
        UIColor(red: random[0]/10, green: random[1]/10, blue: random[2]/10, alpha: 1).setFill()
        // 内側の塗りつぶし
        roundRect.fill()
//        roundRect.lineWidth = 2
//        roundRect.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("began-\(frame.origin)")
        //ViewContorollerの変数を変更
        if let viewController = self.parentViewController() as? ViewController {
            viewController.touchCheck = true
            viewController.oldPosition = frame.origin
        }

        behaviorMode = .MoveWindowPosition

        if let touch = touches.first {
            let location = touch.location(in: self)
            locationInitialTouch = location
            if location.x < bounds.width - 20 && location.y < bounds.height - 20{
//                behaviorMode = .ChangeWindowSize
            }else{
                behaviorMode = .MoveWindowPosition
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//            print("moved")
        if let touch = touches.first {
            let location = touch.location(in: self)
            if behaviorMode == .ChangeWindowSize {            //サイズ変更
//                frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
            }else{  //移動
                frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
            }
        }
        
        //ViewContorollerの変数を変更
        if let viewController = self.parentViewController() as? ViewController {
            viewController.newPosition = frame.origin
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         print("end")
        //ViewContorollerの変数を変更
        if let viewController = self.parentViewController() as? ViewController {
                print("\(viewController.oldPosition)-\(viewController.newPosition)")
        }
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if behaviorMode == .ChangeWindowSize {
//                frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
            }else{
                frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
            }
            behaviorMode = .None
        }
        
        
    }
}
