//
//  TestView.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/28.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

class TestView: UIView {
        enum BehaviorMode : Int{
            case None
            case MoveWindowPosition
            case ChangeWindowSize
        }
        
        private var behaviorMode:BehaviorMode = .None
        
        private var locationInitialTouch:CGPoint!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 0.7)
            self.isUserInteractionEnabled = true
//            self.window = UIWindowLevelAlert
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let location = touch.location(in: self)
                print("Began:(\(location.x), \(location.y))")
                locationInitialTouch = location
                
                if location.x > bounds.width - 20 && location.y > bounds.height - 20{
                    behaviorMode = .ChangeWindowSize
                }else{
                    behaviorMode = .MoveWindowPosition
                }
            }
        }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let location = touch.location(in: self)
                print("Moved:(\(location.x), \(location.y))")
                
                if behaviorMode == .ChangeWindowSize {
                    frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
                }else{
                    frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
                }
            }
        }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let location = touch.location(in: self)
                print("Ended:(\(location.x), \(location.y))")
                
                if behaviorMode == .ChangeWindowSize {
                    frame = CGRect(origin: frame.origin, size: CGSize(width: location.x, height: location.y ))
                }else{
                    frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
                }
                behaviorMode = .None
            }
        }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
