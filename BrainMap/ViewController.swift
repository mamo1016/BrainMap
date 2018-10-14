//
//  ViewController.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/21.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var i: Int = 0
    var j: Int = 0

    // Screen Size の取得
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var circleArray:[Draw] = []
    var draw: Draw!
//    var location: CGPoint!
    var touchCheck: Bool = false
    var position: CGPoint = CGPoint(x:0.0,y:0.0)
    var oldPosition: CGPoint = CGPoint(x:0.0,y:0.0)
    var newPosition: CGPoint = CGPoint(x:0.0,y:0.0)
    var circle: UIView?
    
    var shapeArray: [CAShapeLayer] = []
    
    weak var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
//        //Drawインスタンス作成
//        draw.append(Draw(frame: CGRect(x: screenWidth/2, y: screenHeight/2, width: 70, height: 70)))
//        draw[0].center = self.view.center
//        draw[0].layer.cornerRadius = 35
//        draw[0].layer.masksToBounds = true
//        draw[0].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        self.view.addSubview(draw[0])
        //Drawインスタンス作成
        draw = Draw(frame: CGRect(x: screenWidth/2, y: screenHeight/2, width: 70, height: 70))
        draw.center = self.view.center
        draw.layer.cornerRadius = 35
        draw.layer.masksToBounds = true
        draw.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        draw.tag = i
        self.view.addSubview(draw)


        // 画面背景を設定
        self.view.backgroundColor = UIColor(red:0.85,green:1.0,blue:0.95,alpha:1.0)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.tapped(_:)))
        
        // デリゲートをセット
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        // ロングプレス
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        
        longPressGesture.delegate = self
        
        // Viewに追加.
        self.view.addGestureRecognizer(longPressGesture)
        //            createCircle(x: 100, y: 100) //タッチした座標にしたい
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        
    }
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCheck = false
//        let touchEvent = touches.first! //このタッチイベントの場合確実に1つ以上タッチ点があるので`!`つけてOKです
//        let location = touchEvent.location(in: self.view) //in: には対象となるビューを入れます
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
        
//        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
//
//        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        
    }

    
    func updateCircle() {
        view.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createCircle(){
        //Drawインスタンス作成
        draw = Draw(frame: CGRect(x:position.x, y:position.y-10, width: 70, height: 70))
        //        draw.center = CGPoint(x: location.x, y: location.y)
        draw.layer.cornerRadius = 35
        draw.layer.masksToBounds = true
        draw.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(draw)
        draw.tag = i
        touchCheck = false
//        oldPosition = position
        circle = draw
        i += 1

    }
    
    // Tap イベント
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            print("tap:\(String(describing: sender.view))")
        }
        print(draw.viewWithTag(1))
    }
    
    // Long Press イベント
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
//                print("\(sender.state == .began) && \(draw.inside)")
//        print("longPress:\(sender)")
        if sender.state == .began && touchCheck{
            // 開始は認知される
            createCircle()
        }else if sender.state == .changed {
//            print("change")
//            let location = sender.location(in: view)
//            print(location.x)
//            print(location.y)
            let location = sender.location(in: view)
            var frame = circle?.frame
            frame?.origin = CGPoint(x: location.x-35, y: location.y-35)
            circle?.frame = frame!
            newPosition = (frame?.origin)!
        }else if sender.state == .ended {
            createLine()
            print("end-----")
//            for i in 0 ..< draw.count{
////                print(draw[i].frame.origin)
//            }
            print("\(oldPosition)---\(newPosition)")
        }
    }
    
    func createLine() {
        // remove old shape layer if any
        
//        self.shapeLayer?.removeFromSuperlayer()
        
        // create whatever path you want
        let random: [CGFloat] = [2 + CGFloat(arc4random_uniform(10)), 10 * CGFloat(arc4random_uniform(2))]
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: oldPosition.x+35, y: oldPosition.y+35))    //始点
        if Int(random[0]) % 2 == 0{
            path.addLine(to: CGPoint(x: newPosition.x+35, y: oldPosition.y+35)) //横線
        }else{
            path.addLine(to: CGPoint(x: oldPosition.x+35, y: newPosition.y+35)) //横線
        }
        path.addLine(to: CGPoint(x: newPosition.x+35, y: newPosition.y+35)) //縦線
        
        // create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        shapeLayer.lineWidth = random[0]
        shapeLayer.path = path.cgPath
        
        shapeArray.append(shapeLayer)
//        if shapeArray.count > 2{
//            shapeArray.remove(at: 0)
//        }
        // animate it
        
//        view.layer.addSublayer(shapeLayer)
        //viewにssubLayerを追加
        view.layer.insertSublayer(shapeArray[i-1], at: 0)
//        print("createLine:\(view.layer.)")
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "MyAnimation")
        // save shape layer
        
        self.shapeLayer = shapeLayer
        print("createLine:\(shapeLayer)")
    }
    
    @objc func timerUpdate() {
//        print(touchCheck)
    }
}
