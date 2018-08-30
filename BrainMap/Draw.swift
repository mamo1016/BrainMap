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

//    func centering(x: CGFloat,y: CGFloat){
//        centerX = x
//        centerY = y
//    }
    override func draw(_ rect: CGRect) {
        
        // 角が丸い矩形 -------------------------------------
        roundRect = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 50, height: 50), cornerRadius: 25)
        // stroke 色の設定
        UIColor(red: 0.3, green: 1, blue: 0.2, alpha: 1).setStroke()
        roundRect.lineWidth = 2
        roundRect.stroke()
//        view.layer.cornerRadius = 25
//        print("Draw")
//        view.layer.cornerRadius = 100.0;
//        roundRect.move(to: CGPoint(x:0,y:0))
//
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let viewController = ViewController()
//        ViewController.
//        print(viewController.touchCheck)
        

        if let touch = touches.first {
            let location = touch.location(in: self)
//            print("Began:(\(location.x), \(location.y))")
            locationInitialTouch = location
//            print(location)
            X = frame.origin.x + location.x/2
            Y = frame.origin.y + location.y/2

            if location.x < bounds.width - 20 && location.y < bounds.height - 20{
//                behaviorMode = .ChangeWindowSize
//                print("inside")
                
            }else{
//                print("outside")
                behaviorMode = .MoveWindowPosition
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
//            print("Moved:(\(location.x), \(location.y))")
            
            if behaviorMode == .ChangeWindowSize {            //サイズ変更
//                frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
            }else{  //移動
                frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
//                print(frame.origin)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
//            print("Ended:(\(location.x), \(location.y))")
            
            if behaviorMode == .ChangeWindowSize {
//                frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
            }else{
                frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
            }
            behaviorMode = .None
        }
    }


    
}
